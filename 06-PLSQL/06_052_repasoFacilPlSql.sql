-- A partir de estas tablas y de estos datos de ejemplo:

CREATE TABLE productos (
  codigo VARCHAR(6) PRIMARY KEY,
  nombre VARCHAR(30),
  precio NUMBER(7,2)
);

INSERT INTO productos VALUES ('p1','Producto 1', 23);
INSERT INTO productos VALUES ('p2','Producto 2', 32.5);
INSERT INTO productos VALUES ('p3','Producto 3', NULL);
INSERT INTO productos VALUES ('p4','Producto 4', 23);

-- 1. Muestra el nombre del primer producto (en orden alfabético), usando un bloque anónimo.

-- 2. Muestra el nombre de cada producto y su precio (o "Desconocido", si es nulo), usando un CURSOR y LOOP, como parte de un bloque anónimo.

-- 3. Crea un procedimiento "MostrarListaProductos", que use un CURSOR y WHILE para mostrar el nombre de cada producto y su precio (o "Desconocido", si es nulo"). Pruébalo.

-- 4. Crea una función "ListaDeProductosUnaLinea", que use un CURSOR y FOR para obtener una única línea de texto formada por los nombres de todos los producto. Pruébala.

-- 5. Crea una función "SumaPrecios" que use un FOR con un SELECT incrustado para obtener la suma de todos los precios. Si algún producto no tiene precio, se tomará 15 como su precio. Pruébala.

-- 6. Muestra la cantidad de productos almacenados, mostrando "Ninguno", "Entre 1 y 10", "Entre 11 y 20" o "Más de 20", según corresponda, empleando IF.

-- 7. Muestra la cantidad de productos almacenados, mostrando "Ninguno", "Uno", "Dos", "Tres" o "Más de 3", empleando CASE.

-- 8. Crea un trigger que guarde "Nombre no detallado" en vez de NULL, si en algún caso de intenta guardar un producto con nombre nulo.
