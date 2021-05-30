//-------------------------------------//
//              DllDetect              //
//-------------------------------------//

local luabin = {
    'gmsv_menuhook1_win32',
    'gmsv_menuhook2_win32',
    'gmsv_menuhook3_win32',
    'gmsv_menuhook4_win32',
    'gmsv_menuhook5_win32',
    'gmsv_menuhook6_win32',
}

local countdll = 0

for k,v in pairs (luabin) do
	if countdll >= 1 then
        HelixACDetect('HelixAC::MenuHook')
		return false
    elseif file.Exists('lua/bin/'..v..'.dll', 'MOD') then
		countdll = countdll + 1
    end
end

//-------------------------------------//
//              LuaDetect              //
//-------------------------------------//

local luafile = {
    'menuhook',
    'menuhook.lua',
}

local countlua = 0

for k,v in pairs (luafile) do
	if countlua >= 1 then
        HelixACDetect('HelixAC::MenuHook')
		return false
    elseif file.Exists('lua/'..v, 'MOD') then
		countlua = countlua + 1
    end
end

//-------------------------------------//
//                 End                 //
//-------------------------------------//
