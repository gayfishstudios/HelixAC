
util.AddNetworkString 'HelixAC::Detect'

local function IsSteamID64(str)
	return str:match("^76561[0123]%d%d%d%d+$")
end

local function InfoBan(SteamID)
    local Banned = util.GetPData( SteamID, 'HelixAC::Ban', '[false,"NULL"]' )
    Banned = util.JSONToTable(Banned)
    return Banned
end

concommand.Add('helixac_unban', function(p,c,a,as)
    if not helixac.access[p:GetUserGroup()] then
        print('HelixAC | No Access')
        return false
    end
    local d = IsSteamID64(a[1])
    if d then
        util.SetPData( util.SteamIDFrom64(d), 'HelixAC::Ban', '[false,"NULL"]' )
        print('HelixAC | SteamID64 UnBanned')
    else
        print('HelixAC | SteamID64 Incorrectly')
    end
end, function()
    return false
end)

local reason = {
    ['HelixAC::JIT']                = '#HelixAC | Detect JIT',
    ['HelixAC::Neko']               = '#HelixAC | Detect Neko',
    ['HelixAC::Cobalt']             = '#HelixAC | Detect Cobalt',
    ['HelixAC::Explots']            = '#HelixAC | Detect Explot',
    ['HelixAC::MenuHook']           = '#HelixAC | Detect MenuHook',
    ['HelixAC::External']           = '#HelixAC | Detect External',
    ['HelixAC::Lee']                = '#HelixAC | Detect LeeCheat',
    ['HelixAC::LuaCheat']           = '#HelixAC | Detect LuaCheat',
    ['HelixAC::ScriptHook']         = '#HelixAC | Detect ScriptHook',
    ['HelixAC::Lua']                = '#HelixAC | Detect Lua Executive',
    ['HelixAC::CitizenHack']        = '#HelixAC | Detect CitizenHack Dev',
    ['HelixAC::MethamphetaMine']    = '#HelixAC | Detect MethamphetaMine Dev',
}

hook.Add('CheckPassword', 'HelixAC::Ban:Check', function(SteamID64, IP, ServerPass, ClientPass, ClientName)
    local SteamID = util.SteamIDFrom64(SteamID64)
    local Banned = InfoBan(SteamID)
    if Banned[1] then
        local VACMsg = Banned[2]
        return false, VACMsg
    end
end)

local function HelixACBan(p,t,r)
    if r == 'NULL' then return false end
    local res = reason[r] or "NULL"
    if t == 1 then
        local data = util.TableToJSON({ true, res })
        p:SetPData('HelixAC::Ban', data)
        p:SendLua([[for i=1,math.huge do steamworks.ViewFile(1) end]])
        p:Kick(res)
        return false
    elseif t == 0 then
        p:Kick(res)
        return false
    else
        return false
    end
end

net.Receive('HelixAC::Detect', function(_,p)
    local t = net.ReadInt(8)
    local r = net.ReadString() or 'NULL'
    HelixACBan(p,t,r)
end)