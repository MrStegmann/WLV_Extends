
local addonName, WLVX = ...

--- Crea un componente Card reutilizable utilizando los elementos del framework.
--- Basado en la estructura y estilos definidos en Main.ui.lua.
--- @param parent table El frame donde se alojará la tarjeta.
--- @param id string Identificador único para el componente.
--- @param props table|nil Propiedades de configuración:
---   - title: (string) Título de la tarjeta.
---   - description: (string) Texto descriptivo central.
---   - image: (string) Ruta de una textura/imagen.
---   - icon: (string) Nombre de un icono (si no se provee image).
---   - footerInfo: (string) Texto pequeño informativo al final.
---   - linkText: (string) Texto para un enlace de ayuda o secundario.
---   - buttonText: (string) Texto del botón de acción.
---   - onButtonClick: (function) Callback al presionar el botón principal.
---   - width/height: (number|string) Dimensiones de la tarjeta.
function WLVX:Card(parent, id, props)
    if not parent then return end
    props = props or {}

    -- Definición de estilos locales inspirados en SheetStyles
    local styles = {
        container = {
            width = props.width or 220,
            height = props.height or 360,
            background = { r = 0.15, g = 0.15, b = 0.15, a = 0.95 },
            border = { r = 0.4, g = 0.4, b = 0.4, a = 1 },
            display = "column",
        },
        body = {
            width = "100%",
            height = "100%", -- Ocupa el espacio flexible restante
            display = "column",
            gap = 6
        }
    }

    -- 1. Contenedor Principal (Div)
    local card = WLVX:Div(parent, id, styles.container)

    -- 2. Media / Cabecera (Img)
    if props.image or props.icon then
        WLVX:Img(card, id .. "_Media", {
            src = props.image,
            icon = props.icon,
            width = "100%",
            height = 120
        })
    end

    -- 3. Cuerpo de la tarjeta (Div para agrupar textos y separadores)
    local body = WLVX:Div(card, id .. "_Body", styles.body)

    WLVX:H3(body, id .. "_Title", { text = props.title or "Card Title", width = "100%" })
    WLVX:Hr(body, id .. "_Divider", { width = "100%", color = { 1, 1, 1, 0.15 } })
    
    WLVX:P(body, id .. "_Desc", {
        text = props.description or "Descripción de ejemplo para el componente Card utilizando el sistema atómico.",
        width = "100%",
        height = 60
    })

    WLVX:Small(body, id .. "_FooterInfo", { text = props.footerInfo or "ID: " .. id, width = "100%" })

    if props.linkText then
        WLVX:A(id .. "_Link", body, { text = props.linkText, href = "help", height = 18 })
    end

    -- 4. Acción Principal (Button)
    WLVX:Button(card, id .. "_Action", {
        text = props.buttonText or "Ver Más",
        width = "100%",
        height = 32,
        onClick = props.onButtonClick
    })

    return card
end