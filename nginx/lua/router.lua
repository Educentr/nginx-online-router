local ngx = require 'ngx'

local router = {
    handler = {}
}

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
    if not CONFIG["serviceB.using"] or CONFIG["serviceB.using"] ~= "1" then
        ngx.exit(418)
    end

    if CONFIG["serviceB.host"] and CONFIG["serviceB.host"] ~= "" then
        ngx.var.serviceB_host = CONFIG["serviceB.host"]
    end

    local uri = string.gsub(ngx.var.request_uri, "?.*", "")
    uri = string.gsub(uri, "/", "_")

    ngx.log(ngx.INFO, "uri ", uri);
    if not CONFIG["serviceB.endpoints." .. uri] then
        ngx.exit(418)
    end

    local user_id, user_err = _get_user_id();

    for percent in string.gmatch(CONFIG["serviceB.endpoints." .. uri], "[^,]+") do
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
            if CONFIG["serviceB.accounts"] and ngx.re.match(CONFIG["serviceB.accounets"], "(?:^|,)"..user_id.."(?:,|$)", "oj") then
                return
            end
        else
            ngx.log(ngx.ERR, "error onlineconf param: ", percent)
        end
    end

    ngx.exit(418)
end

return router
