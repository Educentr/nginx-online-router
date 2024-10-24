local counter = 0
local paths = {
	{ path = "/api/v1/users",            method = "GET" },
	{ path = "/api/v1/some_url1",        method = "POST" },
	{ path = "/api/v1/payout/some_url2", method = "PUT" },
}

request = function()
	local req = paths[counter % #paths + 1]
	counter = counter + 1

	if req.method == "GET" then
		return wrk.format("GET", req.path)
	elseif req.method == "POST" then
		return wrk.format("POST", req.path, nil, "key=value")    -- Здесь передается тело для POST
	elseif req.method == "PUT" then
		return wrk.format("PUT", req.path, nil, "update=newValue") -- Здесь тело для PUT
	elseif req.method == "DELETE" then
		return wrk.format("DELETE", req.path)
	end
end
