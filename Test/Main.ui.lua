local addonName, WLVX = ...

local menuId = "mainMenu";
print("WLVX: Creando menú de acciones rápidas con ID:", menuId)

local SheetStyles = {
    mainContainer = {
        width = "100%",
        height = "100%",
        display = "row"
    },
    navBar = {
        width = "25%",
        height = "100%",
        display = "column",
    },
    mainContent = {
        width = "75%",
        height = "100%",
        display = "column",
    },
    header = {
        width = "100%",
        height = 40,
    },
    SheetMainTitle = {
        color = {r = 1, g = 0.9, b = 0.5, a = 1},
        justifyH = "CENTER",
        font = "GameFontNormalLarge",
        height = 32,
        scale = 1.15,
        text = "Ficha de Personaje"
    },
    section = {
        width = "100%",
        height = "100%",
        display = "column",
    }
}
-- Menu siempre visible
local mainMenu= WLVX:CreateMenu(menuId, "", {width = 500, height = 550}, {alwaysVisible = false, movable=true}, function(frame)
    WLVX:SetMargin(frame, 12)

    local mainContainer = WLVX:Div(frame, "MainmenuContainer", SheetStyles.mainContainer)

    -- Barra de navegación lateral izquierda
    local navBar = WLVX:Div(mainContainer, "NavBar", SheetStyles.navBar)

    WLVX:A("charSheet", navBar, 
        {
            text = "Ficha",
            href = "charSheet",
            onClick = function(href) print(href) end,
            width = "100%",
            height = 30,
            justifyH = "CENTER"
        }
    )

    WLVX:A("inventory", navBar, 
        {
            text = "Inventario",
            href = "inventory",
            onClick = function(href) print(href) end,
            width = "100%",
            height = 30,
            justifyH = "CENTER"
        }
    )

    -- End Barra de navegación lateral izquierda

    -- Start Main Content
    local mainContent = WLVX:Main(frame, "MainContent", SheetStyles.mainContent)
    local header = WLVX:Header(mainContent, "MainHeader", SheetStyles.header)
    WLVX:H1(header, "SheetMainTitle", SheetStyles.SheetMainTitle)

    local section = WLVX:Section(mainContent, "MainSection", SheetStyles.section)

    -- Ejemplo de uso del componente Card
    WLVX:Card(section, "Card1", {
        title = "Equipo Actual",
        description = "Aquí puedes ver tu equipo actual y sus estadísticas.",
        image = "Interface\\Icons\\INV_Chest_Chain_03",
        buttonText = "Ver Detalles",
        onButtonClick = function() print("Botón de Card1 clickeado") end,
        linkText = "Más Información"
    })

    -- End Main Content

end)

print("WLVX: Menú de acciones rápidas creado con ID:", menuId)
