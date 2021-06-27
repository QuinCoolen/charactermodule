local plyMeta = FindMetaTable("Player")

function plyMeta:Nick()
    return self:GetNWString("Nickname", false) or self:Nick()
end

function plyMeta:GetName()
    return self:GetNWString("Nickname", false) or self:Nick()
end

function plyMeta:Name()
    return self:GetNWString("Nickname", false) or self:Nick()
end

function plyMeta:SetName(name)
    self:SetNWString("Nickname", name)
end

function plyMeta:GetDesc(desc)
    return self:GetNWString("Description", false) or "This character has no description"
end

function plyMeta:SetDesc(desc)
    self:SetNWString("Description", desc)
end

-- Shamelessly stolen from https://steamcommunity.com/sharedfiles/filedetails/?id=659490574
if CLIENT then
	function parseChat(ply, msg)
		chat.AddText(Color(255, 255, 255, 255), plyMeta:GetName(), color_white, ": ", msg )
		chat.PlaySound()
		return true
	end
	timer.Simple( 5, function()
		
		if hook.GetTable()["OnPlayerChat"] then
		else
			hook.Add( "OnPlayerChat", "NickName_ChatFix", parseChat )
		end
	end)
end