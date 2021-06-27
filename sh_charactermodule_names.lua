local plyMeta = FindMetaTable("Player")

function plyMeta:GetName()
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