local ngx = require("ngx")

local router = {
	handler = {},
	nginx_name = "",
	allowed = {},
	timeout_allowed = 30,
}

function router.handler.init()
	router.nginx_name = os.getenv("NOR_NGINX_NAME") or "default"
	if not pcall(function()
				router.handler.check_allowed()
			end) then
		error("no allowed segments. Add /nginx/{servicename}/segments in onlineconf")
	end
end

function router.handler.check_allowed()
	if not CONFIG[router.nginx_name .. ".segments"] then
		ngx.log(ngx.ERR, "no allowed segmengs. Add /nginx/{servicename}/segments in onlineconf")
		error("no allowed segments. Add /nginx/{servicename}/segments in onlineconf")
	end
end

function router.handler.init_allowed()
	if not pcall(function()
				router.handler.load_allowed()
			end) then
		error("error load allowed segments")
	end
end

function router.handler.load_allowed()
	local refresh_timer = function()
		local list = CONFIG[router.nginx_name .. ".segments"]
		-- Так сделать не получиться. Будет ошибка, потому что list уже table
		-- ngx.log(ngx.INFO, "allowed segments: ", list)

		local allowed = {}
		for _, segment in ipairs(list) do
			allowed[segment] = true
		end

		router.allowed = allowed

		ngx.log(ngx.INFO, "update allowed segments")
	end

	refresh_timer()

	local ok_timer, err_timer = ngx.timer.every(router.timeout_allowed, refresh_timer)
	if not ok_timer then
		ngx.log(ngx.ERR, "Failed to set repeating timer: ", err_timer)
	end
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
	return "_" .. table.concat(segments, "_")
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
	local method = ngx.req.get_method()
	local config_key = router.nginx_name .. ".endpoints." .. method .. uri

	ngx.log(ngx.INFO, "method ", method, " uri ", uri)

	if not CONFIG[config_key] then
		ngx.exit(418)
	end

	local user_id, user_err = _get_user_id()
	local config_value = CONFIG[config_key]

	for value in string.gmatch(config_value, "[^,]+") do
		if value == "off" then
			ngx.exit(418)
		end

		local percent_num = tonumber(value)
		if value == "on" then
			return
		end

		if user_err then
			ngx.log(ngx.ERR, "error get user_id", user_err)
			ngx.exit(418)
		end

		if percent_num and percent_num >= 0 then
			if (user_id % 100) < percent_num then
				return
			end
		elseif value == "list" then
			if
					CONFIG[router.nginx_name .. ".accounts"]
					and ngx.re.match(CONFIG[router.nginx_name .. ".accounts"], "(?:^|,)" .. user_id .. "(?:,|$)", "oj")
			then
				return
			end
		else
			ngx.log(ngx.ERR, "error onlineconf param: ", value)
		end
	end

	ngx.exit(418)
end

return router
