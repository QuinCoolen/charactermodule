local function OpenCharMenu()
    local width, height = ScrW(), ScrH()

    local models = {
        "models/player/alyx.mdl",
        "models/player/eli.mdl",
        "models/player/odessa.mdl",
        "models/player/arctic.mdl",
        "models/player/leet.mdl",
        "models/player/mossman_arctic.mdl"
    }

    local charInfo = {
        "model",
        "name"
    }

    local CharFrame = vgui.Create("DFrame")
    CharFrame:SetSize(width, height)
    CharFrame:MakePopup()
    CharFrame:SetDraggable(false)
    CharFrame:SetSizable(false)

    local CharModelPanel = vgui.Create("DPanel", CharFrame)
    CharModelPanel:SetSize(ScrW() / 2, 0)
    CharModelPanel:Dock(LEFT)
    CharModelPanel.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ))
    end

    local CharModelList = vgui.Create("DIconLayout", CharModelPanel)
    CharModelList:Dock(TOP)
    CharModelList:SetSpaceX(5)
    CharModelList:SetSpaceY(5)

    local CharModel = vgui.Create("DModelPanel", CharModelPanel)    
    CharModel:Dock(LEFT)
    CharModel:SetSize(700, 700)
    function CharModel:LayoutEntity( Entity ) return end -- disables default rotation
    CharModel:SetCamPos(Vector(60, 0, 50)) -- sets the model to face the camera
    CharModel:SetFOV(70)

    for modelCount = 1, #models do -- creats a spawnicon for every model in the above table
        local CharModelItem = CharModelList:Add("SpawnIcon")
        CharModelItem:SetSize(75, 75)
        CharModelItem:SetModel(models[modelCount])
        CharModelItem.DoClick = function() -- when you click on a spawnicon it sets the model in DModelPanel to the selected model
            CharModel:SetModel(models[modelCount])
            charInfo["model"] = CharModel:GetModel()
        end
    end

    local CharInfoPanel = vgui.Create("DPanel", CharFrame)
    CharInfoPanel:SetSize(ScrW() / 2, 0)
    CharInfoPanel:Dock(RIGHT)
    CharInfoPanel.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 0 ))
    end

    local CharNameLabel = vgui.Create("DLabel", CharInfoPanel)
    CharNameLabel:Dock(TOP)
    CharNameLabel:SetText("Enter your character's name here:")

    local CharNameEntry = vgui.Create("DTextEntry", CharInfoPanel)
    CharNameEntry:Dock(TOP)
    CharNameEntry.OnLoseFocus = function( self )
		charInfo["name"] = self:GetValue()
	end

    local CharDescLabel = vgui.Create("DLabel", CharInfoPanel)
    CharDescLabel:Dock(TOP)
    CharDescLabel:SetText("Enter your character's description here:")

    local CharDescEntry = vgui.Create("DTextEntry", CharInfoPanel)
    CharDescEntry:Dock(TOP)
    CharDescEntry:SetMultiline(true)
    CharDescEntry:SetSize(0, 100)
    CharDescEntry.OnLoseFocus = function( self )
		charInfoDesc = self:GetValue() -- since this is optional it doesn't go into the tabel
	end

    local CreateCharButton = vgui.Create("DButton", CharFrame)
    CreateCharButton:SetText("Create Character!")
    CreateCharButton:SetSize(100, 50)
    CreateCharButton:SetPos(width / 2 - 50, height - 100)
    CreateCharButton.DoClick = function()
        if charInfo.model == nil || charInfo.name == nil then -- checks if all required information is filled out via the table
            liro.diagnosticPrint("Something went wrong while creating your character")
        elseif charInfoDesc == nil then
            CharFrame:Close()
            net.Start("CreateChar")
            net.WriteTable(charInfo)
            net.SendToServer()
        else
            CharFrame:Close()
            net.Start("CreateChar")
            net.WriteTable(charInfo)
            net.WriteString(charInfoDesc)
            net.SendToServer()
        end
    end
end
hook.Add("InitPostEntity", "OpenCharOnPlayer", OpenCharMenu)
concommand.Add("opencharmenu", OpenCharMenu)