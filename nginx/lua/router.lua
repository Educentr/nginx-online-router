local ngx = require("ngx")

local router = {
	handler = {},
	nginx_name = "",
	allowed = {},
	timeout_allowed = 30,
}

function router.handler.init()
	router.nginx_name = os.getenv("NOR_NGINX_NAME") or "default"
	-- if not pcall(function()
	-- 	router.handler.check_allowed()
	-- end) then
	-- 	error("no allowed endpoints")
	-- end
end

function router.handler.check_allowed()
	if not CONFIG[router.nginx_name .. ".endpoints.list"] then
		ngx.log(ngx.ERR, "no allowed endpoints. Add /nginx/{servicename}/endpoints/list in onlineconf")
		error("no allowed endpoints. Add /nginx/{servicename}/endpoints/list in onlineconf")
	end
end

function router.handler.init_allowed()
	local refresh_timer
	refresh_timer = function()
		local list = CONFIG[router.nginx_name .. ".endpoints.list"]
		ngx.log(ngx.INFO, "allowed endpoints: ", list)

		local result = {}
		for path in string.gmatch(list, "([^,]+)") do
			table.insert(result, path)
		end

		-- Преобразуем таблицу result в таблицу allowed
		local allowed = {}
		for _, path in ipairs(result) do
			-- Разбиваем путь по символу "/"
			for segment in string.gmatch(path, "[^/]+") do
				-- Добавляем уникальные сегменты в таблицу allowed, исключая {ID}
				if segment ~= "{ID}" then
					allowed[segment] = true
				end
			end
		end
		router.allowed = allowed

		ngx.log(ngx.INFO, "allowed endpoints: ", allowed)

		ngx.timer.at(router.timeout_allowed, refresh_timer)
	end
	refresh_timer()
end

-- Function to replace non-allowed segments with {AnyID}
function router.handler.replace_non_allowed_segments(url)
	-- Split the URL into segments
	local segments = {}
	for segment in url:gmatch("[^/]+") do
		table.insert(segments, segment)
	end

	-- Process each segment
	for i, segment in ipairs(segments) do
		-- Replace "-" with "_" for comparison
		local formatted_segment = segment:gsub("-", "_")
		if not router.allowed[formatted_segment] then
			segments[i] = "{ID}"
		end
	end

	-- Reassemble the URL
	return "/" .. table.concat(segments, "/")
end

local function _get_user_id()
	local headers, err
	headers, err = ngx.req.get_headers()
	if err == "truncated" then
		return nil, "got truncated headers"
	end

	local user_id = headers["X-User-ID"]
	if not user_id or user_id == "" then
		return nil, "no user uid"
	end

	return user_id, nil
end

function router.handler.access()
	ngx.log(ngx.INFO, "nginx name ", router.nginx_name)

	if not CONFIG[router.nginx_name .. ".using"] or CONFIG[router.nginx_name .. ".using"] ~= "1" then
		ngx.exit(418)
	end

	if CONFIG[router.nginx_name .. ".host"] and CONFIG[router.nginx_name .. ".host"] ~= "" then
		ngx.var.serviceB_host = CONFIG[router.nginx_name .. ".host"]
	end

	local uri = string.gsub(ngx.var.request_uri, "?.*", "")
	uri = router.handler.replace_non_allowed_segments(uri)
	uri = string.gsub(uri, "/", "_")
	local method = ngx.req.get_method()
	local config_key = router.nginx_name .. ".endpoints." .. method .. uri

	ngx.log(ngx.INFO, "method ", method, " uri ", uri)

	if not CONFIG[config_key] then
		ngx.exit(418)
	end

	local user_id, user_err = _get_user_id()
	local config_value = CONFIG[config_key]

	for percent in string.gmatch(config_value, "[^,]+") do
		local percent_num = tonumber(percent)
		if percent == "on" then
			return
		end
		if user_err then
			ngx.log(ngx.ERR, "error get user_id", err)
			ngx.exit(418)
		end
		if percent_num and percent_num >= 0 then
			if (user_id % 100) < percent_num then
				return
			end
		elseif percent == "list" then
			if
				CONFIG[router.nginx_name .. ".accounts"]
				and ngx.re.match(CONFIG[router.nginx_name .. ".accounets"], "(?:^|,)" .. user_id .. "(?:,|$)", "oj")
			then
				return
			end
		else
			ngx.log(ngx.ERR, "error onlineconf param: ", percent)
		end
	end

	ngx.exit(418)
end

return router
