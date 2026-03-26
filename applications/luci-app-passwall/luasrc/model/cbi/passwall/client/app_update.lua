local api = require "luci.passwall.api"
local appname = "passwall"

m = Map(appname)
api.set_apply_on_parse(m)

-- [[ App Settings ]]--
s = m:section(TypedSection, "global_app", translate("App Update"),
s.anonymous = true
s:append(Template(appname .. "/app_update/app_version"))

local k, v
local com = require "luci.passwall.com"
for _, k in ipairs(com.order) do
	v = com[k]
	if k ~= "chinadns-ng" then
		o = s:option(Value, k:gsub("%-","_") .. "_file", translatef("%s App Path", v.name))
		o.default = v.default_path or ("/usr/bin/" .. k)
		o.rmempty = false
	end
end

return m
