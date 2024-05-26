local ngx = require 'ngx'


local nginx_onlineconf = {
    onlineconf = require("onlineconf"),
    module = "nginx",
    timeout = 30
}

local onlineconf = nginx_onlineconf.onlineconf
if not pcall(function () CONFIG=onlineconf.module( nginx_onlineconf.module ); end) then
    error("Onlineconf daemon is not running or onlineconf module '" .. nginx_onlineconf.module .. "' does not exist");
end

ngx.log(ngx.INFO, "load config from onlineconf");

function nginx_onlineconf.nginx_init_worker()
    local refresh_timer;
    refresh_timer = function ()
        onlineconf.module( nginx_onlineconf.module );
        ngx.timer.at(nginx_onlineconf.timeout, refresh_timer);
    end
    refresh_timer();
end

return nginx_onlineconf

