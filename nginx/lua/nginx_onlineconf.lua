local ngx = require("ngx")

local nginx_onlineconf = {
	onlineconf = require("onlineconf"),
	module = "nginx",
	timeout = 30,
}

local onlineconf = nginx_onlineconf.onlineconf
if not pcall(function()
	CONFIG = onlineconf.module(nginx_onlineconf.module)
end) then
	error("Onlineconf daemon is not running or onlineconf module '" .. nginx_onlineconf.module .. "' does not exist")
end

ngx.log(ngx.INFO, "load config from onlineconf")

function nginx_onlineconf.nginx_init_worker()
	local function refresh_timer()
		local ok, err = pcall(function()
			onlineconf.module(nginx_onlineconf.module)
		end)

		if not ok then
			ngx.log(ngx.ERR, "Error in refresh_timer: ", err)
		end
	end

	local ok_timer, err_timer = ngx.timer.every(nginx_onlineconf.timeout, refresh_timer)
	if not ok_timer then
		ngx.log(ngx.ERR, "Failed to set repeating timer: ", err_timer)
		error("Failed to set repeating timer: " .. err_timer)
	end
end

return nginx_onlineconf
