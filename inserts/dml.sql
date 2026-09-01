CREATE TEMP TABLE temporal_json (data JSONB);


\copy temporal_json(data) FROM program 'tr -d "\r\n" < /home/camper/Música/WFE/categorias.json';


INSERT into categorias (codigo, nombre, descripcion)
SELECT
    e->>'codigo',
    e->>'nombre',
    e->>'descripcion'
FROM temporal_json as t
CROSS JOIN LATERAL jsonb_array_elements(t.data) AS e;

SELECT categoria_id,codigo,nombre
FROM categorias
ORDER BY categoria_id;
DROP TABLE temporal_json;




CREATE TABLE temporal_xml(data XML);

\copy temporal_xml(data) FROM PROGRAM 'tr -d "\r\n" < /home/camper/POSTGRES-DATA/juegos.xml';

select * from temporal_xml;

insert into juegos (
    codigo,
    titulo,
    precio,
    fecha_lanzamiento,
    categoria_id    
)
select 
    x.codigo,
    x.titulo,
    x.precio,
    x.fecha_lanzamiento,
    c.categoria_id
from temporal_xml as t;
