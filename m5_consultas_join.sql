/*
==================================================
Proyecto: Consultas JOINs
Curso: Data Analytics - Coderhouse
Alumno: Tomás Acosta
Módulo: Consultas SQL con Join y Union
Fecha: 09/08/2026
==================================================
*/
select * from clientes;
select * from productos;
select * from categorias;
select * from ventas;
select * from territorio;

/*
==================================================
Consulta 1 — Vista base del proyecto (INNER JOIN) Combiná ventas, clientes, productos y territorios
para obtener en una sola fila: fecha, nombre del cliente, segmento, región, nombre del producto,
categoría, cantidad, precio unitario, total de venta y canal. Esta consulta será la fuente de datos principal en Power BI.
==================================================
*/

SELECT 
    v.fecha_venta AS fecha,
    c.nombre_cliente AS nombre_cliente,
    c.segmento AS segmento,
    t.region AS region,
    p.nombre_producto AS nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad AS cantidad,
    v.precio_unitario AS precio_unitario,
    v.total_venta AS total_venta,
    v.canal AS canal
FROM ventas v
INNER JOIN clientes c
    ON c.id_cliente = v.id_cliente
INNER JOIN productos p
    ON p.id_producto = v.id_producto
INNER JOIN categorias cat
    ON p.categoria = cat.nombre_categoria
INNER JOIN territorio t
    ON c.id_territorio = t.id_territorio;


/*
==================================================
Consulta 2 — Clientes sin ventas (LEFT JOIN) Identificá clientes registrados que aún no han
realizado ninguna compra. Mostrá su nombre, email y fecha de registro.
Usá WHERE ... IS NULL para aislar los casos.
==================================================
*/

SELECT 
	c.nombre_cliente,
	c.email,
	c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
	ON c.id_cliente = v.id_cliente
WHERE v.id_cliente is NULL;

	
/*
==================================================
Consulta 3 — Productos sin ventas (LEFT JOIN) Identificá productos del catálogo que no
tienen ninguna venta registrada. Mostrá nombre del producto, categoría y precio.
Usá WHERE ... IS NULL.
==================================================
*/

SELECT 
	p.nombre_producto,
	cat.nombre_categoria as categoria,
	p.precio
FROM productos p
LEFT JOIN ventas v
	ON p.id_producto = v.id_producto
INNER JOIN categorias cat
	ON cat.nombre_categoria = p.categoria
WHERE v.id_producto is NULL;


/*
==================================================
Consulta 4 — Consolidado por canal (UNION ALL) Usá UNION ALL para combinar en un
solo resultado las ventas Online y Presencial, agregando una columna canal que
identifique el origen de cada fila. Al final calculá el total por canal con un GROUP BY.
==================================================
*/

SELECT 
	v.id_venta,
	v.total_venta,
	v.canal,
FROM ventas v
WHERE v.canal = 'Presencial'

