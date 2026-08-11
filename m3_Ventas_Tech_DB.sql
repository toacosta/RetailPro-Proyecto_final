/*
==================================================
Proyecto: Ventas Tech DB
Curso: Data Analytics - Coderhouse
Alumno: Tomás Acosta
Módulo: Checkpoint SQL
Fecha: 22/07/2026
==================================================
*/


--- CREAR BASE DE DATOS---

CREATE DATABASE Ventas_Tech_DB;
GO

--- CREAR USO DE LA BASE DE DATOS---

USE Ventas_Tech_DB;
GO

/*==================================================
    ELIMINAR TABLAS SI EXISTEN
==================================================*/

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

/*==================================================
    CREACIÓN DE TABLAS
==================================================*/

CREATE TABLE categorias(
    id_categoria INT NOT NULL PRIMARY KEY,   -- INT almacena un identificador único para cada categoría.
    nombre_categoria VARCHAR(50) NOT NULL, -- VARCHAR permite guardar texto de longitud variable y NOT NULL obliga a completar el dato.
    descripcion VARCHAR(200) NOT NULL -- VARCHAR permite almacenar una descripción de la categoría.
);


CREATE TABLE clientes(
    id_cliente INT NOT NULL PRIMARY KEY, -- INT identifica de forma única a cada cliente.
    nombre VARCHAR(100) NOT NULL, -- VARCHAR(100) permite almacenar nombres de distinta longitud.
    email VARCHAR(100) UNIQUE, -- UNIQUE evita que existan dos clientes con el mismo correo electrónico.
    ciudad VARCHAR(50), -- VARCHAR almacena el nombre de la ciudad del cliente.
    fecha_registro DATE NOT NULL -- DATE guarda únicamente la fecha de registro del cliente.
);


CREATE TABLE productos(
    id_producto INT NOT NULL PRIMARY KEY, -- INT identifica de forma única cada producto.
    nombre_producto VARCHAR(100) NOT NULL, -- VARCHAR permite almacenar nombres de productos.
    id_categoria INT, -- INT almacena el identificador de la categoría relacionada.
    precio  DECIMAL(10,2) NOT NULL, -- DECIMAL evita errores de precisión en valores monetarios.
    stock INT DEFAULT 0, -- INT almacena cantidades enteras disponibles en inventario.
    activo BIT NOT NULL DEFAULT 1 -- TINYINT(1) representa dos estados posibles: 1 = activo, 0 = inactivo.

    FOREIGN KEY (id_categoria)
		REFERENCES categorias(id_categoria)
);


CREATE TABLE ventas(
    id_venta INT PRIMARY KEY, -- INT identifica de forma única cada venta.
    id_cliente INT, -- Relaciona la venta con un cliente existente.
    
    id_producto INT,  -- Relaciona la venta con un producto existente.
    cantidad INT NOT NULL, -- INT almacena la cantidad de unidades vendidas.
    precio_unitario DECIMAL(10,2) NOT NULL, -- DECIMAL almacena el precio de venta con precisión.
    fecha_venta DATE NOT NULL -- DATE registra la fecha en que se realizó la venta.

    FOREIGN KEY (id_cliente) 
        REFERENCES clientes(id_cliente),

    FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);

/*==================================================
    CARGA DE DATOS
==================================================*/

INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');


INSERT INTO clientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');


INSERT INTO productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);


INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');


/*==================================================
    CONSULTAS DE VALIDACIÓN
==================================================*/

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;