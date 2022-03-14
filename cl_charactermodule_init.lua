function GM:InitPostEntity()
    if (charInfo == nil) then
        OpenCharMenu()
    else
        net.Start("LoadChar")
        net.SendToServer()
    end
end

function DeleteCharacter()
    net.Start("DeleteChar")
    net.SendToServer()
end

concommand.Add("deletecharacter", DeleteCharacter)