util.AddNetworkString("CreateChar")

net.Receive("CreateChar", function(len, ply)

	local charInfo = net.ReadTable()
    local charInfoDesc = net.ReadString()
    ply:SetModel(charInfo.model)
    ply:SetName(charInfo.name)
    ply:SetDesc(charInfoDesc)
    ply:ChatPrint(ply:Nick())
    ply:ChatPrint(ply:GetDesc())
end)