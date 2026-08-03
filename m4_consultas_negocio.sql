/*
==================================================
Proyecto: Ventas Tech DB
Curso: Data Analytics - Coderhouse
Alumno: Tomás Acosta
Módulo: Extrayendo métricas clave con SQL
Fecha: 01/08/2026
==================================================
*/

/*==================================================
Consulta 1
Objetivo:
Obtener un resumen mensual de ventas mostrando el
total facturado, la cantidad de pedidos y el ticket
promedio por mes.
==================================================*/

SELECT 
	MONTH(fecha_venta) as mes,
	SUM(cantidad * precio_unitario) as total_facturado,
	COUNT(*) as cantidad_pedidos,
	AVG(cantidad * precio_unitario) as ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta);

/*==================================================
Consulta 2
Objetivo:
Identificar los cinco productos que generan mayor
facturación para detectar los productos más rentables.
==================================================*/

SELECT TOP(5)
	id_producto,
	sum(cantidad) as unidades_vendidas,
	sum(cantidad * precio_unitario) as total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;
	
/*==================================================
Consulta 3
Objetivo:
Encontrar los clientes recurrentes que realizaron
más de un pedido y calcular cuánto gastó cada uno.
==================================================*/

SELECT 
	id_cliente,
	COUNT(*) as cantidad_pedidos,
	sum(cantidad * precio_unitario) as total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;


/*==================================================
Consulta 4
Objetivo:
Comparar la facturación mensual con el promedio
general para identificar meses con desempeño
superior o inferior.
==================================================*/

SELECT
	mes,
	total_facturado,
	CASE
		WHEN total_facturado >
		(
			SELECT AVG(total_facturado)
			FROM
			(
				SELECT
					MONTH(fecha_venta) as mes,
					SUM(cantidad * precio_unitario) as total_facturado
				FROM ventas
				GROUP BY MONTH(fecha_venta)
			) as ventas_por_mes
		)
		THEN 'Por encima'
		ELSE 'Por debajo'
	END AS comparacion
FROM
(
	SELECT
		MONTH(fecha_venta) as mes,
		SUM(cantidad * precio_unitario) as total_facturado
	FROM ventas
	GROUP BY MONTH(fecha_venta)
) as ventas_por_mes;





/*==================================================
Hallazgos

1. Todas las ventas registradas pertenecen al mes
   de marzo, por lo que el análisis mensual muestra
   un único período.

2. El ranking de productos permite identificar cuáles
   generan la mayor facturación y pueden considerarse
   estratégicos para el negocio.

3. La consulta de clientes recurrentes facilita detectar
   clientes con mayor frecuencia de compra, información
   útil para futuras campañas comerciales.
==================================================*/
