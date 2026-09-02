# postgres_pipeline

## Nombre de la base de datos

`pipeline`

## Descripción

La base de datos `pipeline` almacena información de videojuegos organizada por categorías. El proyecto demuestra la importación de datos desde archivos JSON y XML mediante PostgreSQL.

## Explicación de las tablas

### Tabla `categorias`

Almacena las categorías de los videojuegos.

- `categoria_id`: identificador autogenerado y clave primaria.
- `codigo`: código único de tres caracteres.
- `nombre`: nombre de la categoría.
- `descripcion`: descripción de la categoría.

### Tabla `juegos`

Almacena los videojuegos importados desde el archivo XML.

- `juego_id`: identificador autogenerado y clave primaria.
- `codigo`: código único de tres caracteres.
- `titulo`: título del videojuego.
- `precio`: precio del videojuego con dos decimales.
- `fecha_lanzamiento`: fecha de lanzamiento.
- `categoria_id`: identificador de la categoría relacionada.

La tabla `juegos` se relaciona con `categorias` mediante el campo `categoria_id`.

## Explicación de los inserts

### Datos importados desde JSON

1. Se crea la tabla temporal `temporal_json` con una columna de tipo `JSONB`.
2. Se carga el archivo `categorias.json` mediante `\copy`.
3. Se utiliza `jsonb_array_elements` para separar los objetos del archivo JSON.
4. Se extraen los campos `codigo`, `nombre` y `descripcion`.
5. Los datos se insertan en la tabla `categorias`.
6. Se comprueba la información cargada y se elimina la tabla temporal.

### Datos importados desde XML

1. Se crea la tabla temporal `temporal_xml` con una columna de tipo `XML`.
2. Se carga el archivo `juegos.xml` mediante `\copy`.
3. Se comprueba el contenido de la tabla temporal.
4. Los datos se insertan en la tabla `juegos`.
5. Cada videojuego se relaciona con su categoría correspondiente.

Se importan cuatro categorías desde el archivo JSON y veinte videojuegos desde el archivo XML.

## Consultas realizadas

1. Se consultan las cuatro categorías importadas, mostrando su identificador, código, nombre y descripción.
2. Se consultan los veinte videojuegos importados desde el archivo XML.
3. Se calcula el promedio global de precios y el promedio de precios por categoría mediante funciones de ventana.
4. Se muestran los ocho videojuegos cuyo precio supera el promedio global.
5. Se utiliza un `LEFT JOIN` para mostrar cada videojuego junto con el nombre de su categoría.

## Autores

- Wilder Catu
- Brandon Ixen