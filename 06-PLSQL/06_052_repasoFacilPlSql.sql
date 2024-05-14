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


-- 1. Muestra el nombre del primer producto (en orden alfabético), 
-- usando un bloque anónimo.

DECLARE
    v_nombre productos.nombre % TYPE;
    
BEGIN
    SELECT nombre INTO v_nombre
    FROM productos ORDER BY nombre
    FETCH NEXT 1 ROWS ONLY;

    dbms_output.put_line(v_nombre);
END;


-- 2. Muestra el nombre de cada producto y su precio (o "Desconocido",
-- si es nulo), usando un CURSOR y LOOP, como parte de un bloque anónimo.

DECLARE
    CURSOR cursorProd IS
        SELECT nombre, precio FROM productos
        ORDER BY nombre;
        
    v_nombre productos.nombre % TYPE;
    v_precio productos.precio % TYPE;
    
BEGIN
    OPEN cursorProd;
    LOOP
        FETCH cursorProd INTO v_nombre, v_precio;
        EXIT WHEN cursorProd % NOTFOUND;
        IF v_precio IS NULL THEN
            dbms_output.put_line(v_nombreç 
                || ': Desconocido');
        ELSE
            dbms_output.put_line(v_nombre 
                || ': ' || v_precio);
        END IF;
    END LOOP;
    CLOSE cursorProd;
END;


-- 3. Crea un procedimiento "MostrarListaProductos", que use un CURSOR 
-- y WHILE para mostrar el nombre de cada producto y su precio 
-- (o "Desconocido", si es nulo"). Pruébalo.

CREATE OR REPLACE PROCEDURE MostrarListaProductos
AS
    CURSOR cursorProd IS
        SELECT nombre, precio FROM productos
        ORDER BY nombre;
    v_nombre productos.nombre % TYPE;
    v_precio productos.precio % TYPE;
    
BEGIN
    OPEN cursorProd;
    FETCH cursorProd INTO v_nombre, v_precio;
    WHILE cursorProd % FOUND LOOP
        IF v_precio IS NULL THEN
            dbms_output.put_line(v_nombre 
                || ': Desconocido');
        ELSE
            dbms_output.put_line(v_nombre 
                || ': ' || v_precio);
        END IF;
        
        FETCH cursorProd INTO v_nombre, v_precio;
    END LOOP;
    CLOSE cursorProd;
END MostrarListaProductos;

EXECUTE MostrarListaProductos;

-- Versión con ROWTYPE

CREATE OR REPLACE PROCEDURE MostrarListaProductos
AS
    CURSOR cursorProd IS
        SELECT * FROM productos
        ORDER BY nombre;
    v_producto productos % ROWTYPE;
    
BEGIN
    OPEN cursorProd;
    FETCH cursorProd INTO v_producto;
    WHILE cursorProd % FOUND LOOP
        IF v_producto.precio IS NULL THEN
            dbms_output.put_line(v_producto.nombre 
                || ': Desconocido');
        ELSE
            dbms_output.put_line(v_producto.nombre 
                || ': ' || v_producto.precio);
        END IF;
        
        FETCH cursorProd INTO v_producto;
    END LOOP;
    CLOSE cursorProd;
END MostrarListaProductos;

--

BEGIN
    MostrarListaProductos;
END;


-- 4. Crea una función "ListaDeProductosUnaLinea", que use un CURSOR y 
-- FOR para obtener una única línea de texto formada por los nombres 
-- de todos los producto. Pruébala.

CREATE OR REPLACE FUNCTION ListaDeProductosUnaLinea
RETURN VARCHAR2
AS
    v_lista VARCHAR2(500) := '';
    CURSOR cursorProd IS
        SELECT nombre FROM productos
        ORDER BY nombre;
BEGIN
    FOR prod IN cursorProd LOOP
        v_lista := v_lista || ',' || prod.nombre;
    END LOOP;
    --RETURN v_lista;
    RETURN SUBSTR(v_lista,2);
    
END ListaDeProductosUnaLinea;

--

BEGIN
  dbms_output.put_line(ListaDeProductosUnaLinea);
END;

--

SELECT ListaDeProductosUnaLinea FROM dual;


-- 5. Crea una función "SumaPrecios" que use un FOR con un SELECT
-- incrustado para obtener la suma de todos los precios. Si algún 
-- producto no tiene precio, se tomará 15 como su precio. Pruébala.

CREATE OR REPLACE FUNCTION SumaPrecios
RETURN NUMBER
AS
    v_suma NUMBER := 0;

BEGIN
    FOR prod IN ( SELECT precio FROM productos
            ORDER BY nombre) LOOP
        IF prod.precio IS NULL THEN
            v_suma := v_suma + 15;
        ELSE
            v_suma := v_suma + prod.precio;
        END IF;
    END LOOP;
    RETURN v_suma;
    
END SumaPrecios;

--

SELECT SumaPrecios FROM dual;


-- 6. Muestra la cantidad de productos almacenados, mostrando "Ninguno", 
-- "Entre 1 y 10", "Entre 11 y 20" o "Más de 20", según corresponda, 
-- empleando IF.

DECLARE
    cantidad NUMBER(3);
BEGIN
    SELECT COUNT(*)
    INTO cantidad
    FROM productos;

    IF cantidad = 0 THEN
        dbms_output.put_line('Ninguno');
    ELSIF cantidad > 0 AND cantidad <= 10 THEN
        dbms_output.put_line('Entre 1 y 10');
    ELSIF cantidad > 10 AND cantidad <= 20 THEN
        dbms_output.put_line('Entre 11 y 20');
    ELSE 
        dbms_output.put_line('Más de 20');
    END IF;
END;



-- 7. Muestra la cantidad de productos almacenados, mostrando "Ninguno",
-- "Uno", "Dos", "Tres" o "Más de 3", empleando CASE.

DECLARE
    cantidad NUMBER(3);
BEGIN
    SELECT COUNT(*)
    INTO cantidad
    FROM productos;

    CASE cantidad 
        WHEN 0 THEN
            dbms_output.put_line('Ninguno');
        WHEN 1 THEN
            dbms_output.put_line('Uno');
        WHEN 2 THEN
            dbms_output.put_line('Dos');
        WHEN 3 THEN
            dbms_output.put_line('Tres');
        ELSE
            dbms_output.put_line('Más de 3');
    END CASE;
END;

-- 8. Crea un trigger que guarde "Nombre no detallado" en vez de NULL, 
-- si en algún caso de intenta guardar un producto con nombre nulo.

CREATE OR REPLACE TRIGGER revisarNombreProducto
BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
    IF :NEW.nombre IS NULL THEN
        :NEW.nombre := 'Nombre no detallado';
    END IF;
END;

INSERT INTO productos VALUES ('p5', NULL, 8);

SELECT * FROM productos;

