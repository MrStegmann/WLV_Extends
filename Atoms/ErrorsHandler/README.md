# ErrorsHandler

## Resumen

Contendrá un archivo index.lua que servirá de exportador para ser consumido. Tendrá la función maestra para el manejo de errores que recibirá por parámetro: codeError, ...params.

- codeError: Es un código de tipo de error para que la función identifique el tipo de error y devuelta un mensaje de error acorde.
- ...params: Son parámetros extra de información necesaria.

Habrá un archivo con el nombre de archivo del cúal maneja los errores seguido de la palabra".errors.lua". Por ejemplo: "Core.errors.lua"
