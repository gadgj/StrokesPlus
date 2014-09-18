

function sp_before_action(gnm, gsx, gsy, gex, gey, gwd, gapp, gact)

        acActivateWindow(aGetAncestor(acGetWindowByPoint(gsx, gsy), GA_ROOT), 0, 0)

end

aliencore = alien.core

user32 = aliencore.load("user32.dll")

-- ************ GetAncestor ************

gGetAncestor = user32.GetAncestor

gGetAncestor:types{ ret = 'long', abi = 'stdcall', 'long', 'uint'}

GA_PARENT = 1

GA_ROOT = 2

GA_ROOTOWNER = 3

function aGetAncestor(iWnd, iFlags)

        return gGetAncestor(iWnd, iFlags)

end

--******************************************

--************ BackupConfig ************

function BackupConfig(source, destination)

	local BUFSIZE = 2^14;

	local fInHandle = io.open(source, "rb");

	local fOutHandle = io.open(destination, "wb");

	local current = fInHandle:seek()      -- get current position

	local size = fInHandle:seek("end")    -- get file size

	fInHandle:seek("set", current)        -- restore position

	local blocks = math.floor(size / BUFSIZE);

	local remainder = size - (blocks * BUFSIZE);

	for i = 1, blocks do

		data = fInHandle:read(BUFSIZE);

		fOutHandle:write(data);

		pos = 1000 * i * BUFSIZE / size;

	end

	if (remainder > 0) then

		data = fInHandle:read(remainder);

		fOutHandle:write(data);

	end

	fInHandle:close();

	fOutHandle:close();

end

--local SourceFolder = "C:\\Users\\YI\\AppData\\Roaming\\StrokesPlus\\" --源文件路径
--local BackupFolder = "D:\\BackupCenter\\StrokesPlus\\" --备份文件路径
local SourceFolder = "F:/InstallPackage/StrokesPlus_x86/" --源文件路径
local BackupFolder = "F:/InstallPackage/StrokesPlus_x86/bak/" --备份文件路径

BackupConfig(SourceFolder.."StrokesPlus.xml", BackupFolder.."StrokesPlus.xml_"..os.date("%Y-%m"))
BackupConfig(SourceFolder.."StrokesPlus.lua", BackupFolder.."StrokesPlus.lua_"..os.date("%Y-%m"))
