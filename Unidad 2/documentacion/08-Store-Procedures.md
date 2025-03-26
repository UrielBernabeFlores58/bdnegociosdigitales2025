## Store Procedures

## Ejercicio 8 de la Unidad 2

```sql
--- Crear un store procedure para seleccionar todos los clientes

CREATE OR ALTER PROCEDURE spu_mostrar_clientes
AS
BEGIN 
    SELECT * FROM Customers;
END;
GO  

EXEC spu_mostrar_clientes;
GO

-- Crear un sp que muestre los clientes por pais
-- Parámetros de entrada

CREATE OR ALTER PROC spu_customersporpais
-- Parámetros 
@pais NVARCHAR(15), -- Parámetro de entrada
@pais2 NVARCHAR(16)
AS
BEGIN
    SELECT * FROM Customers
    WHERE Country IN (@pais, @pais2);
END;

EXEC spu_customersporpais 'Spain', 'Germany';

-- Opción con variables
DECLARE @p1 NVARCHAR(15) = 'spain';
DECLARE @p2 NVARCHAR(15) = 'germany';

EXEC spu_customersporpais @p1, @p2;
GO

/*
-- Crear un reporte que permita visualizar los datos de compra de un determinado cliente
en un rango de fechas mostrando el monto total de compras por un producto mediante un sp
*/

CREATE OR ALTER PROC spu_informe_ventas_clientes
-- Parámetros
@nombre NVARCHAR(40), -- Parámetro de entrada con valor por defecto
@fechaInicial DATETIME,
@fechaFinal DATETIME
AS 
BEGIN
    SELECT [nombre producto], SUM(importe) AS [Monto Total] 
    FROM VistaOrdenesdeCompra
    WHERE [Nombre del cliente] = @nombre
      AND [Fecha de Orden] BETWEEN @fechaInicial AND @fechaFinal
    GROUP BY [nombre producto], [Nombre del cliente];
END;
GO

CREATE OR ALTER PROC spu_informe_ventas_clientes
-- Parámetros
@nombre NVARCHAR(40) = 'Berglunds snabbk�p', -- Parámetro de entrada con valor por defecto
@fechaInicial DATETIME,
@fechaFinal DATETIME
AS 
BEGIN
    SELECT [nombre producto], [Nombre del cliente], SUM(importe) AS [Monto Total] 
    FROM VistaOrdenesdeCompra
    WHERE [Nombre del cliente] = @nombre
      AND [Fecha de Orden] BETWEEN @fechaInicial AND @fechaFinal
    GROUP BY [nombre producto], [Nombre del cliente];
END;
GO

SELECT GETDATE();

-- Ejecución de un store con parámetros de entrada
EXEC spu_informe_ventas_clientes 'Berglunds snabbk�p', '1996-07-04', '1997-01-01';

-- Ejecución de un store con parámetros en diferente posición
EXEC spu_informe_ventas_clientes @FechaInicial = '1996-07-04', @FechaFinal = '1997-01-01';

-- Ejecución de un store con parámetros de entrada con un campo que tiene un valor por defecto
EXEC spu_informe_ventas_clientes @FechaFinal = '1997-01-01', @nombre = 'Berglunds snabbk�p', @FechaInicial = '1996-07-04';

-- Store procedure con parámetros de salida
CREATE OR ALTER PROC spu_obtener_numero_clientes
@customerid NCHAR(5), -- Parámetro de entrada,
@totalCustomers INT OUTPUT -- Parámetro de salida
AS 
BEGIN
    SELECT @totalCustomers = COUNT(*) FROM Customers
    WHERE CustomerID = @customerid;
END;
GO

-- Declarar una variable para el total de clientes
DECLARE @numero INT; 
EXEC spu_obtener_numero_clientes 'ANATR', @totalCustomers = @numero OUTPUT;
PRINT @numero;
GO

-- Store procedure que permita saber si un alumno aprobó o reprobó
CREATE OR ALTER PROC spu_comparar_calificacion
@calificacion DECIMAL(10,2) -- Parámetro de entrada
AS
BEGIN
    IF @calificacion >= 0 AND @calificacion <= 10
    BEGIN
        IF @calificacion >= 8
            PRINT 'La calificación es aprobatoria';
        ELSE 
            PRINT 'La calificación es reprobatoria';
    END
    ELSE 
        PRINT 'Calificación no válida';
END;
GO	

EXEC spu_comparar_calificacion @calificacion = <valor>;

-- Crear un sp que permita verificar si un cliente existe antes de devolver su información
CREATE OR ALTER PROC spu_obtener_cliente_siexiste
@numeroCliente NCHAR(5)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @numeroCliente)
        SELECT * FROM Customers WHERE CustomerID = @numeroCliente;
    ELSE
        PRINT 'El cliente no existe';
END;
GO

SELECT 1 FROM Customers WHERE CustomerID = 'ANATR';

EXEC spu_obtener_cliente_siexiste @numeroCliente = 'Arout';

-- Crear un store procedure que permita insertar un cliente
-- Pero se debe verificar primero que no exista
CREATE OR ALTER PROC spu_agregar_cliente
@id NCHAR(5),
@nombre VARCHAR(40),
@city NVARCHAR(15) = 'San Miguel'
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @id)
    BEGIN
        PRINT ('El Cliente ya existe');
        RETURN 1;
    END
    INSERT INTO Customers (CustomerID, CompanyName)
    VALUES (@id, @nombre);
    PRINT ('Cliente insertado exitosamente');
    RETURN 0;
END;
GO

-- Execuciones de ejemplo
EXEC spu_agregar_cliente 'ORDEP', 'Industrias Corporativas SACV', 'San Miguel';
EXECUTE spu_agregar_cliente 'AlFKI', 'Patito� de Hule';
EXECUTE spu_agregar_cliente 'AlFKC', 'Patito� de Hule';

CREATE OR ALTER PROCEDURE spu_agregar_cliente_try_catch
@id NCHAR(5),
@nombre NVARCHAR(40),
@city NVARCHAR(15) = 'San Miguel'
AS
BEGIN
    BEGIN TRY
        INSERT INTO Customers (CustomerID, CompanyName)
        VALUES (@id, @nombre);
        PRINT('Cliente insertado exitosamente');
    END TRY
    BEGIN CATCH
        PRINT('El cliente ya existe');
    END CATCH;
END;

EXEC spu_agregar_cliente 'ALFKD', 'Mu�eca� Vieja';
GO

CREATE OR ALTER PROCEDURE spu_ciclo_imprimir
@numero INT
AS
BEGIN
    IF @numero <= 0
    BEGIN
        PRINT('El número no puede ser 0 o negativo');
        RETURN;
    END

    DECLARE @i INT;
    SET @i = 1;

    WHILE (@i <= @numero)
    BEGIN
        PRINT('Número ' + @i);
    END;
END;
GO

EXEC spu_ciclo_imprimir @numero = 100;

-- Realizar un pedido con un Store Procedure
-- Validar que el pedido no exista
-- Validar que el cliente, el empleado y el producto existan
-- La cantidad a vender debe ser validada, que haya suficiente stock del producto
-- Insertar el pedido y calcular el importe (multiplicando el precio del producto
-- por la cantidad vendida)
-- Actualizar el stock del producto (restando el stock menos la cantidad vendida)

USE BDEJEMPLO2;
SELECT * FROM Pedidos;
GO

CREATE OR ALTER PROCEDURE spu_pedido_submit
@numpedido INT,
@cliente INT,
@rep INT,
@fab CHAR(3),
@producto CHAR(5),
@cantidad INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT('El pedido ya existe');
        RETURN;
    END	

    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @cliente) OR
       NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @rep) OR
       NOT EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto)
    BEGIN
        PRINT('Los datos no son válidos');
        RETURN;
    END

    IF @cantidad <= 0 
    BEGIN
        PRINT('La cantidad no puede ser 0 o negativa');
        RETURN;
    END

    DECLARE @stockValido INT;
    SELECT @stockValido = stock FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto;

    IF @cantidad > @stockValido
    BEGIN
        PRINT 'No hay suficiente stock';
        RETURN;
    END
	
    DECLARE @precio MONEY, @importe MONEY;
    SELECT @precio = Precio FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto;
    SET @importe = @cantidad * @precio;	
	
    BEGIN TRY
        -- Se inserta un pedido
        INSERT INTO Pedidos
        VALUES (@numpedido, GETDATE(), @cliente, @rep, @fab, @producto, @cantidad, @importe);
        UPDATE Productos
        SET Stock = Stock - @cantidad
        WHERE Id_fab = @fab AND Id_producto = @producto;
    END TRY
    BEGIN CATCH
        PRINT 'Error al actualizar datos';
        RETURN;
    END CATCH;
END;
-- (Num_Pedido, Cliente, Rep, Fab, Producto, Cantidad);
GO

EXECUTE spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep = 106, @fab = 'REI', @producto = '2A44L', @cantidad = 20;

EXECUTE spu_pedido_submit @numpedido = 11370, @cliente = 2117, @rep = 111, @fab = 'REI', @producto = '2A44L', @cantidad = 20;

EXECUTE spu_pedido_submit @numpedido = 11370, @cliente = 2117, @rep = 101, @fab = 'ACI', @producto = '4100X', @cantidad = 20;

SELECT * FROM Productos WHERE Id_fab = 'ACI' AND Id_producto = '4100x';

/*
create or alter procedure sp_datos_de_compra
@NumerodeOrden INT,
@OrdenFecha DATETIME,
@Total MONEY
AS
    SELECT * FROM VistaOrdenesdeCompra
    WHERE YEAR([Fecha de Orden]) IN (1996, 1998);
 
EXEC sp_datos_de_compra @NumerodeOrden = 10250, @OrdenFecha = 1998, @Total = 26.00;
DROP PROCEDURE sp_datos_de_compra;

SELECT [Nombre del cliente] FROM VistaOrdenesdeCompra
ORDER BY 1 ASC;
GO
*/



```

## Ejemplos de Prueba (No son de clase)

``` sql
-- Registrar un nuevo cliente
CREATE OR ALTER PROCEDURE spu_cliente_insert
    @num_cli INT,
    @empresa VARCHAR(20),
    @rep_cli INT,
    @limite_credito MONEY
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @num_cli)
    BEGIN
        PRINT 'El cliente ya existe';
        RETURN;
    END

    INSERT INTO Clientes (Num_Cli, Empresa, Rep_Cli, Limite_Credito)
    VALUES (@num_cli, @empresa, @rep_cli, @limite_credito);

    PRINT 'Cliente registrado exitosamente';
END;

-- 2 Este procedimiento actualiza el límite de crédito de un cliente existente.
CREATE OR ALTER PROCEDURE spu_cliente_update_credito
    @num_cli INT,
    @nuevo_limite MONEY
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @num_cli)
    BEGIN
        PRINT 'El cliente no existe';
        RETURN;
    END

    UPDATE Clientes
    SET Limite_Credito = @nuevo_limite
    WHERE Num_Cli = @num_cli;

    PRINT 'Límite de crédito actualizado';
END;

-- 3 Este procedimiento elimina un cliente si no tiene pedidos.
CREATE OR ALTER PROCEDURE spu_cliente_delete
    @num_cli INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @num_cli)
    BEGIN
        PRINT 'El cliente no existe';
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM Pedidos WHERE Cliente = @num_cli)
    BEGIN
        PRINT 'No se puede eliminar el cliente porque tiene pedidos registrados';
        RETURN;
    END

    DELETE FROM Clientes WHERE Num_Cli = @num_cli;

    PRINT 'Cliente eliminado correctamente';
END;

-- 4 Este procedimiento es similar al que compartiste, pero optimizado.
CREATE OR ALTER PROCEDURE spu_pedido_insert
    @numpedido INT,
    @cliente INT,
    @rep INT,
    @fab CHAR(3),
    @producto CHAR(5),
    @cantidad INT
AS
BEGIN
    DECLARE @stock INT, @precio MONEY, @importe MONEY;

    IF EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido ya existe';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @cliente)
        OR NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @rep)
        OR NOT EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto)
    BEGIN
        PRINT 'Datos inválidos';
        RETURN;
    END

    IF @cantidad <= 0 
    BEGIN
        PRINT 'Cantidad inválida';
        RETURN;
    END

    SELECT @stock = Stock, @precio = Precio FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto;

    IF @cantidad > @stock
    BEGIN
        PRINT 'Stock insuficiente';
        RETURN;
    END

    SET @importe = @cantidad * @precio;

    BEGIN TRANSACTION;
    INSERT INTO Pedidos VALUES (@numpedido, GETDATE(), @cliente, @rep, @fab, @producto, @cantidad, @importe);
    UPDATE Productos SET Stock = Stock - @cantidad WHERE Id_fab = @fab AND Id_producto = @producto;
    COMMIT TRANSACTION;

    PRINT 'Pedido registrado correctamente';
END;

-- 5 Este procedimiento permite modificar la cantidad de un producto en un pedido
CREATE OR ALTER PROCEDURE spu_pedido_update_cantidad
    @numpedido INT,
    @cantidad_nueva INT
AS
BEGIN
    DECLARE @cantidad_actual INT, @producto CHAR(5), @fab CHAR(3), @stock INT, @precio MONEY, @importe MONEY;

    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe';
        RETURN;
    END

    SELECT @producto = Producto, @fab = Fab, @cantidad_actual = Cantidad FROM Pedidos WHERE Num_Pedido = @numpedido;
    SELECT @stock = Stock, @precio = Precio FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto;

    IF @cantidad_nueva > (@stock + @cantidad_actual)
    BEGIN
        PRINT 'Stock insuficiente';
        RETURN;
    END

    SET @importe = @cantidad_nueva * @precio;

    BEGIN TRANSACTION;
    UPDATE Pedidos SET Cantidad = @cantidad_nueva, Importe = @importe WHERE Num_Pedido = @numpedido;
    UPDATE Productos SET Stock = Stock + @cantidad_actual - @cantidad_nueva WHERE Id_fab = @fab AND Id_producto = @producto;
    COMMIT TRANSACTION;

    PRINT 'Cantidad de pedido actualizada';
END;

-- 6 Este procedimiento elimina un pedido y regresa el stock.
CREATE OR ALTER PROCEDURE spu_pedido_delete
    @numpedido INT
AS
BEGIN
    DECLARE @cantidad INT, @producto CHAR(5), @fab CHAR(3);

    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe';
        RETURN;
    END

    SELECT @producto = Producto, @fab = Fab, @cantidad = Cantidad FROM Pedidos WHERE Num_Pedido = @numpedido;

    BEGIN TRANSACTION;
    DELETE FROM Pedidos WHERE Num_Pedido = @numpedido;
    UPDATE Productos SET Stock = Stock + @cantidad WHERE Id_fab = @fab AND Id_producto = @producto;
    COMMIT TRANSACTION;

    PRINT 'Pedido eliminado y stock restaurado';
END;

-- 7 Este procedimiento registra un producto.	
CREATE OR ALTER PROCEDURE spu_producto_insert
    @id_fab CHAR(3),
    @id_producto CHAR(5),
    @descripcion VARCHAR(20),
    @precio MONEY,
    @stock INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @id_fab AND Id_producto = @id_producto)
    BEGIN
        PRINT 'El producto ya existe';
        RETURN;
    END

    INSERT INTO Productos VALUES (@id_fab, @id_producto, @descripcion, @precio, @stock);

    PRINT 'Producto agregado exitosamente';
END;

-- 8 Este procedimiento cambia el precio de un producto.
CREATE OR ALTER PROCEDURE spu_producto_update_precio
    @id_fab CHAR(3),
    @id_producto CHAR(5),
    @nuevo_precio MONEY
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @id_fab AND Id_producto = @id_producto)
    BEGIN
        PRINT 'El producto no existe';
        RETURN;
    END

    UPDATE Productos
    SET Precio = @nuevo_precio
    WHERE Id_fab = @id_fab AND Id_producto = @id_producto;

    PRINT 'Precio actualizado';
END;

/*
-- 1 Realizar una devolución de pedido
Validaciones:
 El pedido debe existir
 Se debe verificar si la cantidad a devolver es válida
 Se debe restaurar el stock
*/
CREATE OR ALTER PROCEDURE spu_pedido_devolucion
    @numpedido INT,
    @cantidad_devuelta INT
AS
BEGIN
    DECLARE @cantidad_actual INT, @producto CHAR(5), @fab CHAR(3);

    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe';
        RETURN;
    END

    -- Obtener datos del pedido
    SELECT @producto = Producto, @fab = Fab, @cantidad_actual = Cantidad
    FROM Pedidos WHERE Num_Pedido = @numpedido;

    -- Validar que la cantidad devuelta no sea mayor a la cantidad original
    IF @cantidad_devuelta > @cantidad_actual OR @cantidad_devuelta <= 0
    BEGIN
        PRINT 'Cantidad inválida para devolución';
        RETURN;
    END

    -- Transacción para actualizar el pedido y restaurar el stock
    BEGIN TRANSACTION;
    UPDATE Pedidos SET Cantidad = Cantidad - @cantidad_devuelta WHERE Num_Pedido = @numpedido;
    UPDATE Productos SET Stock = Stock + @cantidad_devuelta WHERE Id_fab = @fab AND Id_producto = @producto;
    COMMIT TRANSACTION;

    PRINT 'Devolución procesada correctamente';
END;

/*
-- 2 Aplicar un descuento a un pedido
Validaciones:
El pedido debe existir
El descuento no puede hacer que el importe sea negativo
*/
CREATE OR ALTER PROCEDURE spu_pedido_descuento
    @numpedido INT,
    @descuento MONEY
AS
BEGIN
    DECLARE @importe_actual MONEY;

    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe';
        RETURN;
    END

    -- Obtener importe actual
    SELECT @importe_actual = Importe FROM Pedidos WHERE Num_Pedido = @numpedido;

    -- Validar que el descuento no haga que el importe sea negativo
    IF @descuento >= @importe_actual OR @descuento < 0
    BEGIN
        PRINT 'Descuento inválido';
        RETURN;
    END

    -- Aplicar descuento
    UPDATE Pedidos SET Importe = Importe - @descuento WHERE Num_Pedido = @numpedido;

    PRINT 'Descuento aplicado correctamente';
END;

/*
3-- Transferir un pedido a otro representante
Validaciones:
El pedido debe existir
El nuevo representante debe existir
*/
CREATE OR ALTER PROCEDURE spu_pedido_transferir_rep
    @numpedido INT,
    @nuevo_rep INT
AS
BEGIN
    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe';
        RETURN;
    END

    -- Validar que el nuevo representante exista
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @nuevo_rep)
    BEGIN
        PRINT 'El representante no existe';
        RETURN;
    END

    -- Actualizar el representante del pedido
    UPDATE Pedidos SET Rep = @nuevo_rep WHERE Num_Pedido = @numpedido;

    PRINT 'Pedido transferido correctamente';
END;

/*
-- 4 Cancelar un pedido
Validaciones:
 El pedido debe existir
 Se debe restaurar el stock
*/
CREATE OR ALTER PROCEDURE spu_pedido_cancelar
    @numpedido INT
AS
BEGIN
    DECLARE @cantidad INT, @producto CHAR(5), @fab CHAR(3);

    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe';
        RETURN;
    END

    -- Obtener datos del pedido
    SELECT @producto = Producto, @fab = Fab, @cantidad = Cantidad FROM Pedidos WHERE Num_Pedido = @numpedido;

    -- Transacción para cancelar el pedido y restaurar stock
    BEGIN TRANSACTION;
    DELETE FROM Pedidos WHERE Num_Pedido = @numpedido;
    UPDATE Productos SET Stock = Stock + @cantidad WHERE Id_fab = @fab AND Id_producto = @producto;
    COMMIT TRANSACTION;

    PRINT 'Pedido cancelado correctamente';
END;

/*
-- 5 Verificar si un representante ha cumplido su cuota
Validaciones:
El representante debe existir
 Se deben sumar los importes de sus pedidos
*/
CREATE OR ALTER PROCEDURE spu_rep_verificar_cuota
    @rep INT
AS
BEGIN
    DECLARE @cuota MONEY, @ventas MONEY;

    -- Validar que el representante exista
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @rep)
    BEGIN
        PRINT 'El representante no existe';
        RETURN;
    END

    -- Obtener cuota y ventas
    SELECT @cuota = Cuota FROM Representantes WHERE Num_Empl = @rep;
    SELECT @ventas = ISNULL(SUM(Importe), 0) FROM Pedidos WHERE Rep = @rep;

    -- Validar si cumplió la cuota
    IF @ventas >= @cuota
        PRINT 'El representante ha cumplido su cuota';
    ELSE
        PRINT 'El representante no ha cumplido su cuota';
END;

/*
-- 6 Consultar los productos con menos stock
*/
CREATE OR ALTER PROCEDURE spu_productos_bajo_stock
    @limite INT
AS
BEGIN
    SELECT * FROM Productos WHERE Stock < @limite;
END;

/*
-- 7 Cambiar el jefe de una oficina
Validaciones:
 La oficina debe existir
 El nuevo jefe debe existir
*/
CREATE OR ALTER PROCEDURE spu_oficina_cambiar_jefe
    @oficina INT,
    @nuevo_jefe INT
AS
BEGIN
    -- Validar que la oficina exista
    IF NOT EXISTS (SELECT 1 FROM Oficinas WHERE Oficina = @oficina)
    BEGIN
        PRINT 'La oficina no existe';
        RETURN;
    END

    -- Validar que el nuevo jefe exista
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @nuevo_jefe)
    BEGIN
        PRINT 'El representante no existe';
        RETURN;
    END

    -- Actualizar jefe
    UPDATE Oficinas SET Jef = @nuevo_jefe WHERE Oficina = @oficina;

    PRINT 'Jefe actualizado correctamente';
END;

/*
-- 8 Generar reporte de ventas de un representante
*/
CREATE OR ALTER PROCEDURE spu_reporte_ventas_rep
    @rep INT
AS
BEGIN
    -- Validar que el representante exista
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @rep)
    BEGIN
        PRINT 'El representante no existe';
        RETURN;
    END

    -- Generar reporte de ventas
    SELECT Num_Pedido, Fecha_Pedido, Cliente, Producto, Cantidad, Importe
    FROM Pedidos WHERE Rep = @rep
    ORDER BY Fecha_Pedido DESC;
END;

/* 
-- 9 Generar un informe de desempeño de representantes
Crea un Store Procedure que genere un informe detallado sobre el desempeño de los representantes de ventas.
El procedimiento debe calcular varios indicadores clave y devolver los resultados en una consulta.
Requerimientos del procedimiento
 Verificar que el representante exista.
 Calcular el total de pedidos gestionados por el representante.
 Calcular la cantidad total de productos vendidos por el representante.
 Calcular el monto total de ventas generadas por el representante.
 Calcular el porcentaje de cumplimiento de cuota:

Si el representante ya ha superado su cuota, debe indicar cuánto ha sobrepasado.
Si no ha cumplido la cuota, debe mostrar el porcentaje restante.
 Determinar si el representante ha cumplido su cuota (SI o NO).
 Si el representante no ha realizado ventas, mostrar "Sin Ventas" en el informe.
 Manejo de errores con TRY-CATCH.
*/

SELECT * FROM Representantes;
GO

CREATE OR ALTER PROCEDURE spu_reporte_desempe�o
@numempleado INT
AS
BEGIN
    BEGIN TRANSACTION;

    -- Verificar si el representante existe
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @numempleado)
    BEGIN
        RAISERROR('El representante no existe', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Declarar variables para cálculos
    DECLARE @totalPedidos INT, 
            @totalProductosVendidos INT, 
            @totalVentas MONEY, 
            @cuota MONEY, 
            @porcentajeCumplimiento FLOAT, 
            @estadoCumplimiento VARCHAR(10);

    -- Obtener la cuota del representante
    SELECT @cuota = Cuota FROM Representantes WHERE Num_Empl = @numempleado;
	
    -- Calcular el total de pedidos gestionados
    SELECT @totalPedidos = COUNT(*) FROM Pedidos WHERE Rep = @numempleado;

    -- Calcular la cantidad total de productos vendidos
    SELECT @totalProductosVendidos = SUM(Cantidad) FROM Pedidos WHERE Rep = @numempleado;

    -- Calcular el monto total de ventas generadas
    SELECT @totalVentas = SUM(Importe) FROM Pedidos WHERE Rep = @numempleado;

    -- Si el representante no ha realizado ventas, establecer valores predeterminados
    IF @totalPedidos IS NULL
        SET @totalPedidos = 0;
    IF @totalProductosVendidos IS NULL
        SET @totalProductosVendidos = 0;
    IF @totalVentas IS NULL
        SET @totalVentas = 0;

    -- Calcular el porcentaje de cumplimiento de cuota
    IF @cuota > 0
        SET @porcentajeCumplimiento = (@totalVentas / @cuota) * 100;
    ELSE
        SET @porcentajeCumplimiento = 0; -- Evitar división por cero

    -- Determinar si ha cumplido su cuota
    IF @totalVentas >= @cuota
        SET @estadoCumplimiento = 'SI';
    ELSE
        SET @estadoCumplimiento = 'NO';

    BEGIN TRY
        -- Devolver los resultados
        SELECT 
            @numempleado AS Num_Empleado,
            @totalPedidos AS Total_Pedidos,
            @totalProductosVendidos AS Total_Productos_Vendidos,
            @totalVentas AS Total_Ventas,
            @cuota AS Cuota_Asignada,
            @porcentajeCumplimiento AS Porcentaje_Cumplimiento,
            @estadoCumplimiento AS Cumplio_Cuota,
            CASE 
                WHEN @totalVentas = 0 THEN 'Sin Ventas'
                ELSE 'Ventas Realizadas'
            END AS Estado_Ventas;
        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RAISERROR('Error al generar el reporte de desempeño', 16, 1);
    END CATCH;
END;
GO

SELECT * FROM Representantes;
SELECT * FROM Representantes WHERE Cuota IS NULL OR Ventas IS NULL;

-- Prueba: Representante con ventas
EXEC spu_reporte_desempe�o @numempleado = 104;
ROLLBACK TRANSACTION;

SELECT * FROM Pedidos;
SELECT SUM(Importe) FROM Pedidos WHERE Rep = 104; -- 58633,00
```