-- local addonName, WLVX = ...

-- local menuId = "QuickActionsMenu";

-- -- Menu siempre visible
-- WLVX:CreateMenu(menuId, "", true, 300, 150, true, function(frame)
--     WLVX:ApplyPresetStyle(frame, "ArcaneNeon")
    
--     -- Fila de botones superior
--     WLVX:AddRow(frame, menuId .. "_Row1", "100%", 30, function(row)
--         WLVX:SetBackgroundColor(row, 1.0, 0, 0, 0.5)
--         WLVX:AddIconButton(row, "70_inscription_deck_immortality", 20, 20, function() print("Acción 1 ejecutada") end)
--     end)
--     -- Fila de botones Inferior
--     WLVX:AddRow(frame, menuId .. "_Row2", "100%", 30, function(row)
--         WLVX:SetBackgroundColor(row, 0.0, 1.0, 0, 0.5)
--         WLVX:AddButton(row, "Acción 2", 80, 20, function() print("Acción 2 ejecutada") end)
--     end)
-- end)

-- print("|cff00ff00[WLV_UI]|r Test UI cargada correctamente.")