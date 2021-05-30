

helixac = helixac or {}
helixac.cfg = helixac.cfg or {}

if (CLIENT) then
    code = "print(\"HelixAC - Ломатель ебал v2\")"
    RunString(code,"\rtest.lua")

    local data = render.Capture( {
        format = "jpeg",
        quality = 70,
        h = ScrH(),
        w = ScrW(),
        x = 0,
        y = 0,
    })
    if string.find(data, 'Violations of the constitutional right to covert correspondence') then
        net.Start('HelixAC::Detect')
            net.WriteInt(helixac.cfg['BanOrKick'],8)
            net.WriteString('HelixAC::Neko')
        net.SendToServer()
    end
end

helixac.cfg['BanOrKick'] = 0

helixac.access = {
    ['root'] = true
}

local total_lib = 0
local total_core = 0
local total_module = 0

pMeta	= FindMetaTable 'Player'
eMeta	= FindMetaTable 'Entity'
vMeta	= FindMetaTable 'Vector'

helixac.IncludeSV = (SERVER) and include or function() end
helixac.IncludeCL = (SERVER) and AddCSLuaFile or include
helixac.IncludeSH = function(f) AddCSLuaFile(f) return include(f) end

local function loadCore()
    for _, f in ipairs( file.Find( "ac_core/sh_*.lua", "LUA" ) ) do
        helixac.IncludeSH("ac_core/"..f)
    end
    for _, f in ipairs( file.Find( "ac_core/cl_*.lua", "LUA" ) ) do
        helixac.IncludeCL("ac_core/"..f)
    end
    for _, f in ipairs( file.Find( "ac_core/sv_*.lua", "LUA" ) ) do
        helixac.IncludeSV("ac_core/"..f)
    end
    local _, dir = file.Find( "ac_core/*", "LUA" )
    for k,v in ipairs(dir) do
        for _, f in ipairs( file.Find( "ac_core/".. v .."/sh_*.lua", "LUA" ) ) do
            helixac.IncludeSH("ac_core/"..v.."/"..f)
        end
        for _, f in ipairs( file.Find( "ac_core/".. v .."/cl_*.lua", "LUA" ) ) do
            helixac.IncludeCL("ac_core/"..v.."/"..f)
        end
        for _, f in ipairs( file.Find( "ac_core/".. v .."/sv_*.lua", "LUA" ) ) do
            helixac.IncludeSV("ac_core/"..v.."/"..f)
        end
    end
end

local function loadModule()
    local _, dir = file.Find( "ac_module/*", "LUA" )
    for k,v in ipairs(dir) do
        for _, f in ipairs( file.Find( "ac_module/".. v .."/sh_*.lua", "LUA" ) ) do
            helixac.IncludeSH("ac_module/"..v.."/"..f)
        end
        for _, f in ipairs( file.Find( "ac_module/".. v .."/cl_*.lua", "LUA" ) ) do
            helixac.IncludeCL("ac_module/"..v.."/"..f)
        end
        for _, f in ipairs( file.Find( "ac_module/".. v .."/sv_*.lua", "LUA" ) ) do
            helixac.IncludeSV("ac_module/"..v.."/"..f)
        end
    end
end

loadCore()
loadModule()