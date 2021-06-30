local plyMeta = FindMetaTable("Player")

function plyMeta:Nick() -- For everything except kill feed
    return self:GetNWString("Nickname", self:GetName())
end

function plyMeta:Name() -- For kill feed 
    return self:GetNWString("Nickname", self:GetName())
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
	timer.Simple( 5, function()	
		hook.Add( "OnPlayerChat", "NickName_ChatFix", function(ply, msg)
			chat.AddText(Color(255, 255, 255, 255), ply:Nick(), color_white, ": ", msg )
			chat.PlaySound()
			return true
		end)
	end)
end
