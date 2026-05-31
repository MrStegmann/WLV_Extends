local addonName, WLVX = ...

local menuId = "QuickActionsMenu";

-- Menu siempre visible
WLVX:CreateMenu(menuId, "", true, 300, 150, true, function(frame)
    WLVX:ApplyPresetStyle(frame, "ArcaneNeon")
    WLVX:SetPadding(frame, 10)
    print("WLVX: Menu creado correctamente:", menuId)
end)

print("WLVX: Menú de acciones rápidas creado con ID:", menuId)

