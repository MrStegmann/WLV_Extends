local addonName, WLVX = ...

local menuId = "QuickActionsMenu";

-- Menu siempre visible
local mainMenu= WLVX:CreateMenu(menuId, "", true, 300, 150, true, function(frame)
    WLVX:ApplyPresetStyle(frame, "ArcaneNeon")
    WLVX:SetMargin(frame, 10)
    WLVX:SetGap(frame, 5)

    WLVX:AddRow(frame, menuId .. "_Row1", '100%', 50, function(row)
        WLVX:SetMargin(row, 15)
        WLVX:SetBackgroundColor(row, 0.8, 0.1, 0.1, 0.8)
        WLVX:AddIconButton(row, menuId .. "_Btn1", "INV_Misc_Herb_AncientLichen", 24, 24, function() print("Acción rápida 1 ejecutada") end)
        WLVX:AddIconButton(row, menuId .. "_Btn2", "INV_Misc_Herb_AncientLichen", 24, 24, function() print("Acción rápida 2 ejecutada") end)
    end)

    WLVX:AddRow(frame, menuId .. "_Row2", '100%', 50, function(row)
        WLVX:SetBackgroundColor(row, 0.1, 0.8, 0.1, 0.8)
        WLVX:AddIconButton(row, menuId .. "_Btn1", "INV_Misc_Herb_AncientLichen", 24, 24, function() print("Acción rápida 1 ejecutada") end)
        WLVX:AddIconButton(row, menuId .. "_Btn2", "INV_Misc_Herb_AncientLichen", 24, 24, function() print("Acción rápida 2 ejecutada") end)
    end)
end)

print("WLVX: Menú de acciones rápidas creado con ID:", menuId)
