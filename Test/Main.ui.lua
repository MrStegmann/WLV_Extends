-- local addonName, WLVX = ...

-- local menuId = "mainMenu";
-- print("WLVX: Creando menú de acciones rápidas con ID:", menuId)

-- local SheetStyles = {
--     mainContainer = {
--         width = "100%",
--         height = "100%",
--         display = "row"
--     },
--     navBar = {
--         width = "25%",
--         height = "100%",
--         display = "column",
--     },
--     mainContent = {
--         width = "75%",
--         height = "100%",
--         display = "column",
--     },
--     header = {
--         width = "100%",
--         height = 40,
--     },
--     SheetMainTitle = {
--         color = {r = 1, g = 0.9, b = 0.5, a = 1},
--         justifyH = "CENTER",
--         font = "GameFontNormalLarge",
--         height = 32,
--         scale = 1.15,
--         text = "Ficha de Personaje"
--     },
--     section = {
--         width = "100%",
--         height = "100%",
--         display = "column",
--     }
-- }
-- -- Menu siempre visible
-- local mainMenu= WLVX:CreateMenu(menuId, "", {width = 500, height = 550}, {alwaysVisible = true, movable=true})  
-- WLVX:SetMargin(mainMenu, 12)

-- -- Barra de navegación lateral izquierda
-- local navBar = WLVX:Div(mainMenu, "NavBar", SheetStyles.navBar)
-- WLVX:SetBackgroundColor(navBar, 0.1, 0.1, 1, 0.8)





-- print("WLVX: Menú de acciones rápidas creado con ID:", menuId)
