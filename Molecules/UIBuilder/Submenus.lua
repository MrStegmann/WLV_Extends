local addonName, WLVX = ...

WLVX.Submenus = {}

--- Este módulo proporciona funciones para crear menús contextuales con submenús en el addon WLVX. Permite generar menús dinámicos con opciones y subopciones, facilitando la navegación y organización de las acciones disponibles para el usuario.
--- @param title string Titulo del menú contextual.
--- @param options table Tabla de opciones con todas las opciones para el menú contextual. Si tuviera hijos, cada opción padre contendrá un campo 'text' para el nombre y un campo 'subOptions' que contendrá una tabla de las opciones hijas, que podrá contener a su vez más opciones hijas, y así sucesivamente. Los hijos finales tendrán un campo 'text' para el nombre y un campo 'func' que es la función a ejecutar al seleccionar esa opción.
function WLVX:CreateContextMenuOptions(title, options)
    -- Helper function to recursively build menu items
    local function buildMenuRecursive(optionsTable)
        local menuItems = {}
        for _, optionData in ipairs(optionsTable) do
            local menuItem = {
                text = optionData.text,
                notCheckable = true, -- Default for context menu items
            }

            for key, value in pairs(optionData) do
                if key ~= "subOptions" then
                    menuItem[key] = value
                end
            end

            if optionData.subOptions then
                menuItem.hasArrow = true
                menuItem.menuList = buildMenuRecursive(optionData.subOptions)
            end
            table.insert(menuItems, menuItem)
        end
        return menuItems
    end

    local menu = {
        {
            text = title,
            isTitle = true,
            notCheckable = true,
        }
    }

    -- Ensure options is a table, default to empty if nil
    options = options or {}

    -- Build the rest of the menu using the recursive helper
    local subMenus = buildMenuRecursive(options)
    for _, item in ipairs(subMenus) do
        table.insert(menu, item)
    end

    return {proccess = true, menu = menu}
end


--- Crea un menú contextual utilizando la función `CreateContextMenuOptions` para generar las opciones del menú. Este método se puede llamar desde cualquier parte del addon para mostrar un menú contextual con las opciones deseadas. El menú se mostrará en la posición del cursor o en una posición específica si se proporciona un frame de anclaje.
---@param id string Identificador único para el menú contextual.
---@param frame table (opcional) Frame al que se anclará el menú contextual.
---@param options table (opcional) Tabla de opciones con todas las opciones para el menú contextual. Si tuviera hijos, cada opción padre contendrá un campo 'text' para el nombre y un campo 'subOptions' que contendrá una tabla de las opciones hijas, que podrá contener a su vez más opciones hijas, y así sucesivamente. Los hijos finales tendrán un campo 'text' para el nombre y un campo 'func' que es la función a ejecutar al seleccionar esa opción.
function WLVX:CreateContextMenu(id, frame, options)
    if not id then
        error("ID is required to create a context menu.")
    end
    if not frame then
        print("No frame provided for context menu with ID: " .. id .. ".")
    end

    if not options then
        print("No options provided for context menu with ID: " .. id)
    end

    local menuOptions = options and options.proccess and options.menu or self:CreateContextMenuOptions("Menu", options).menu

    if not WLVX.Submenus[id] then
        WLVX.Submenus[id] = CreateFrame("Frame", id, UIParent, "UIDropDownMenuTemplate")
    end
    -- Anclar el menú: bottom del menú con el top del frame de botones
    EasyMenu(menuOptions, WLVX.Submenus[id], frame, 0, 0, "MENU", 2)
end
