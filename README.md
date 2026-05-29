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

Crea un botón persistente y arrastrable en el minimapa.

- **Parámetros**: `iconName`, `frameId`, `callback`.

---

## 🧬 Construcción de UI (Molecules)

Todas las funciones de construcción reciben como primer parámetro el **parent** (el frame o contenedor donde se alojarán).

### Estructura

| Función       | Descripción                                                             |
| :------------ | :---------------------------------------------------------------------- |
| `AddRowTo`    | Crea una fila horizontal. Gestiona el espacio vertical automáticamente. |
| `AddColumnTo` | Crea una columna dentro de una fila. Gestiona el espacio horizontal.    |
| `AlignTo`     | Alinea un frame a: "Top", "Bottom", "Left", "Right" o "Center".         |

### Elementos

| Función         | Descripción                                  |
| :-------------- | :------------------------------------------- |
| `AddHeaderTo`   | Texto grande dorado para títulos de sección. |
| `AddButtonTo`   | Botón estándar con callback al hacer clic.   |
| `AddLabelTo`    | Texto informativo sencillo.                  |
| `AddCheckboxTo` | Casilla de verificación (On/Off).            |
| `AddSliderTo`   | Barra deslizante para valores numéricos.     |
| `AddDropdownTo` | Menú desplegable de selección.               |

---

## 📖 Ejemplo Práctico (Basado en Main.ui.lua)

### 1. Crear un Menú Estándar

```lua
WLVX:CreateMenu("MiMenu", "Título del Addon", true, 600, 400, false, function(frame)
    -- Todo lo que escribas aquí dentro se añadirá al menú
    WLVX:AddHeader(frame, "Sección Principal")
end)
```

### 2. Crear Layout de Columnas (Panel Izquierdo y Derecho)

Para crear una barra lateral de navegación y un área de contenido:

```lua
WLVX:AddRow(frame, "Cuerpo", 300, 580, function(row)
    -- Columna izquierda (Navegación)
    WLVX:AddColumn(row, "Nav", 100, nil, function(col)
        WLVX:AlignTo(col, "Left")
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

_Desarrollado con ❤️ para la comunidad de Epsilon._
