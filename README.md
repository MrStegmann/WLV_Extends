# 🚀 WLV_Extends Framework

Framework de UI basado en arquitectura atómica para el desarrollo rápido de addons en World of Warcraft.

## 🏗️ Conceptos Básicos

El sistema utiliza una jerarquía de contenedores. Para crear una interfaz, el flujo siempre es:

1. **Crear el Menú** (Frame principal).
2. **Añadir Estructura** (Filas y Columnas).
3. **Añadir Contenido** (Botones, Etiquetas, Inputs).

---

## 🛠️ Funciones Principales (Atoms)

### `WLVX:CreateMenu`

Crea la ventana principal.

- **Parámetros**: `id`, `title`, `movable`, `width`, `height`, `alwaysVisible`, `callback`.
- **Uso**: El `callback` recibe el objeto `frame` para empezar a construir dentro.

### `WLVX:CreateMinimapButton`

Crea un botón persistente, arrastrable y con guardado de posición en el minimapa.

- **Parámetros**: `iconName`, `frameId`, `callback`.

---

## 🧬 Construcción de UI (Molecules)

Todas las funciones de construcción reciben como primer parámetro el **parent** (el frame o contenedor donde se alojarán).

### Estructura y Layout

| Función        | Descripción                                                             |
| :------------- | :---------------------------------------------------------------------- |
| `AddRow`       | Crea una fila horizontal. Gestiona el espacio vertical automáticamente. |
| `AddColumn`    | Crea una columna dentro de una fila. Gestiona el espacio horizontal.    |
| `AddContainer` | Crea un contenedor genérico con soporte para desbordamiento.            |
| `Align`        | Alinea un frame a: "Top", "Bottom", "Left", "Right" o "Center".         |

### Estilo y Espaciado

| Función              | Descripción                                                                  |
| :------------------- | :--------------------------------------------------------------------------- |
| `SetMargin`          | Define el margen interno (espacio entre el borde del padre y sus hijos).     |
| `SetGap`             | Define el espacio uniforme entre cada uno de los elementos hijos.            |
| `ApplyPresetStyle`   | Aplica temas predefinidos ("Glass", "Neon", "ArcaneNeon", "CyberBlue", etc). |
| `SetBackgroundColor` | Cambia el color de fondo del frame.                                          |

### Elementos

| Función          | Descripción                                  |
| :--------------- | :------------------------------------------- |
| `AddHeader`      | Texto grande dorado para títulos de sección. |
| `AddButton`      | Botón estándar de la interfaz de WoW.        |
| `AddIconButton`  | Botón circular o cuadrado basado en iconos.  |
| `AddLabel`       | Texto informativo sencillo.                  |
| `AddCheckbox`    | Casilla de verificación (On/Off).            |
| `AddSlider`      | Barra deslizante para valores numéricos.     |
| `AddEditBox`     | Campo de entrada de texto.                   |
| `AddDropdown`    | Menú desplegable de selección múltiple.      |
| `AddColorPicker` | Botón que abre el selector de color de WoW.  |
| `AddKeybind`     | Selector de teclas para asignaciones.        |

---

## 📖 Ejemplo Práctico (Basado en Main.ui.lua)

### 1. Crear un Menú con Márgenes y Gaps

```lua
local menuId = "MiMenu"
WLVX:CreateMenu(menuId, "Mi Addon", true, 300, 200, false, function(frame)
    WLVX:ApplyPresetStyle(frame, "ArcaneNeon")
    WLVX:SetMargin(frame, 15) -- 15px de espacio desde los bordes
    WLVX:SetGap(frame, 10)    -- 10px de separación entre elementos

    WLVX:AddHeader(frame, "Configuración")
    WLVX:AddButton(frame, "btn_1", "Guardar", nil, nil, function() print("Guardado") end)
end)
```

### 2. Layout de Columnas y Filas

Para crear una barra lateral de navegación y un área de contenido:

```lua
WLVX:AddRow(frame, "Cuerpo", 300, 580, function(row)
    WLVX:SetGap(row, 5)

    -- Columna izquierda (Navegación)
    WLVX:AddColumn(row, "Nav", 100, nil, function(col)
        WLVX:Align(col, "Left")
        WLVX:AddButton(col, "Opciones", function() print("Click!") end)
    end)

    -- Columna derecha (Contenido)
    WLVX:AddColumn(row, "Main", 480, nil, function(col)
        WLVX:AddLabel(col, "Este es el contenido principal")
    end)
end)
```

### 3. Menú "Always Visible" (HUD)

Si necesitas un panel que no se pueda cerrar y esté siempre en pantalla (como un widget de estadísticas):

```lua
WLVX:CreateMenu("MiHUD", "Stats", true, 200, 50, true, function(frame)
    WLVX:AddLabel(frame, "Oro: 100g")
end)
```

### 4. Integración con Minimapa

Para que el usuario pueda abrir y cerrar tu menú fácilmente:

```lua
WLVX:CreateMinimapButton("INV_Misc_Gear_01", "MiMenu", function(btn)
    WLVX:CreateMinimapButtonTooltip(btn, "Mi Addon", {
        { text = "Click para abrir configuración", r = 1, g = 0.82, b = 0 }
    })
end)
```

---

## 🎨 Sistema de Iconos

El framework valida automáticamente los iconos. Si usas un nombre que no existe, se mostrará el icono de interrogación por defecto.

- **Ruta base**: `Interface\Icons\`
- **Ejemplo**: Si pasas `"spell_fire_fireball"`, el sistema buscará `Interface\Icons\spell_fire_fireball`.

---
