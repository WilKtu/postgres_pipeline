-- ===================================================
-- Icarga categorias.json y muestra que hay 4 categoras
--  

SELECT
categoria_id,
codigo,
nombre,
descripcion
FROM categorias
ORDER BY categoria_id 
LIMIT 4;


--  categoria_id | codigo |    nombre     |                                    descripcion                                     
-- --------------+--------+---------------+------------------------------------------------------------------------------------
--             1 | RPG    | Juegos de Rol | Aventuras inmersivas centrándose en la narrativa y la evolución de los personajes.
--             2 | EST    | Estrategia    | Títulos enfocados en el pensamiento táctico, planificación y gestión de recursos.
--             3 | ACC    | Acción        | Juegos dinámicos con combate en tiempo real, plataformas y pruebas de reflejo.
--             4 | DEP    | Deportes      | Simulaciones de disciplinas deportivas individuales y de equipo.
-- (4 rows)


-- =========================================================================
-- Importa XML 
-- carga juegos.xml y demuestra que hay 20 juegos

select * from juegos LIMIT 20;

-- juego_id | codigo |              titulo              | precio | fecha_lanzamiento | categoria_id 
----------+--------+----------------------------------+--------+-------------------+--------------
--         1 | TW3    | The Witcher 3: Wild Hunt         |  39.99 | 2015-05-19        |            1
--         2 | ELD    | Elden Ring                       |  59.99 | 2022-02-25        |            1
--         3 | CPK    | Cyberpunk 2077                   |  49.99 | 2020-12-10        |            1
--         4 | BG3    | Baldurs Gate 3                   |  59.99 | 2023-08-03        |            1
--         5 | AOE    | Age of Empires IV                |  39.99 | 2021-10-28        |            2
--         6 | CIV    | Sid Meiers Civilization VI       |  29.99 | 2016-10-21        |            2
--         7 | SC2    | StarCraft II: Legacy of the Void |  19.99 | 2015-11-10        |            2
--         8 | HOI    | Hearts of Iron IV                |  39.99 | 2016-06-06        |            2
--         9 | DME    | Doom Eternal                     |  29.99 | 2020-03-20        |            3
--        10 | GOW    | God of War Ragnarok              |  59.99 | 2022-11-09        |            3
--        11 | RDR    | Red Dead Redemption 2            |  49.99 | 2018-10-26        |            3
--        12 | SEK    | Sekiro: Shadows Die Twice        |  39.99 | 2019-03-22        |            3
--        13 | FC2    | EA Sports FC 24                  |  69.99 | 2023-09-29        |            4
--        14 | NBA    | NBA 2K24                         |  59.99 | 2023-09-08        |            4
--        15 | F12    | F1 23                            |  49.99 | 2023-06-16        |            4
--        16 | RLG    | Rocket League                    |   0.00 | 2015-07-07        |            4
--        17 | SKY    | The Elder Scrolls V: Skyrim      |  19.99 | 2011-11-11        |            1
--        18 | XCO    | XCOM 2                           |  24.99 | 2016-02-05        |            2
--        19 | DMC    | Devil May Cry 5                  |  29.99 | 2019-03-08        |            3
--        20 | PGA    | PGA Tour 2K23                    |  34.99 | 2022-10-14        |            4



-- ================================================================================
-- compara
-- obtener los 8 juegos sobre el promedio global y los 10 sobre su categoria


with promedios as (
    select 
        c.codigo, 
        c.nombre AS categoria, 
        j.precio,
        AVG(j.precio) OVER() as promedio_global,
        AVG(j.precio) over(
            partition by c.categoria_id
        ) as promedio_categoria
    from juegos as j
    inner join categorias as c
    on j.categoria_id = c.categoria_id
)
SELECT
        categoria,
        precio,
        round(promedio_global, 2) as promedio_global,
        round(promedio_categoria, 2) as
        promedio_categoria
    FROM promedios
    WHERE precio > promedio_global
    ORDER BY categoria;


--    categoria   | precio | promedio_global | promedio_categoria 
-- ---------------+--------+-----------------+--------------------
--  Acción        |  49.99 |           40.49 |              41.99
--  Acción        |  59.99 |           40.49 |              41.99
--  Deportes      |  49.99 |           40.49 |              42.99
--  Deportes      |  59.99 |           40.49 |              42.99
--  Deportes      |  69.99 |           40.49 |              42.99
--  Juegos de Rol |  59.99 |           40.49 |              45.99
--  Juegos de Rol |  49.99 |           40.49 |              45.99
--  Juegos de Rol |  59.99 |           40.49 |              45.99
-- (8 rows)



--============================================================
SELECT 
        juego_id,
        titulo,
        c.nombre AS categoria
    FROM juegos AS j
    LEFT JOIN categorias AS c
        ON j.categoria_id = c.categoria_id
    ORDER BY c.categoria_id;

-- juego_id |              titulo              |   categoria   
-- ----------+----------------------------------+---------------
--         1 | The Witcher 3: Wild Hunt         | Juegos de Rol
--         4 | Baldurs Gate 3                   | Juegos de Rol
--        17 | The Elder Scrolls V: Skyrim      | Juegos de Rol
--         2 | Elden Ring                       | Juegos de Rol
--         3 | Cyberpunk 2077                   | Juegos de Rol
--         6 | Sid Meiers Civilization VI       | Estrategia
--         7 | StarCraft II: Legacy of the Void | Estrategia
--        18 | XCOM 2                           | Estrategia
--         8 | Hearts of Iron IV                | Estrategia
--         5 | Age of Empires IV                | Estrategia
--        11 | Red Dead Redemption 2            | Acción
--         9 | Doom Eternal                     | Acción
--        10 | God of War Ragnarok              | Acción
--        12 | Sekiro: Shadows Die Twice        | Acción
--        19 | Devil May Cry 5                  | Acción
--        16 | Rocket League                    | Deportes
--        14 | NBA 2K24                         | Deportes
--        13 | EA Sports FC 24                  | Deportes
--        20 | PGA Tour 2K23                    | Deportes
--        15 | F1 23                            | Deportes
-- (20 rows)

--