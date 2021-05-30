
local VerifiedSources = {}
local HelixAC_CheckSource = {}

HelixAC_CheckSource["[C]"] = false
HelixAC_CheckSource["RunString"] = true
HelixAC_CheckSource["RunStringEx"] = false
HelixAC_CheckSource["CompileString"] = false
HelixAC_CheckSource["LuaCmd"] = false

local function HelixAC_DetectExternal(p)
    local source = string.sub(jit.util.funcinfo(p).source, 2)
    local _jit = jit.util.funcinfo(p)
    if VerifiedSources[source] then return end
    VerifiedSources[source] = true
    if source == "external" then
        HelixACDetect('HelixAC::External')
    end
    if _jit.source == "@" && _jit.loc == ":0" then
        HelixACDetect('HelixAC::Lua')
    end
end

jit.attach(HelixAC_DetectExternal, "bc")