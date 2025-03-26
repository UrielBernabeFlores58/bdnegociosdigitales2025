# Ejercicio Store Procedure

## Ejercicio 9 de la Unidad 2

```sql
-- Realizar un pedido
-- Validar que el pedido no exista
-- Validar que el cliente, el empleado y producto exista
-- Validar que la cantidad a vender tenga suficiente stock
-- Insertar el pedido y calcular el importe (multiplicando el precio del
-- del producto por cantidad vendida)
-- Actualizar el stock del producto (restando el stock menos la cantidad 
-- vendida)

CREATE OR ALTER PROCEDURE spu_realizar_pedido
@numPedido INT, 
@cliente INT, 
@repre INT, 
@fab CHAR(3),
@producto CHAR(5), 
@cantidad INT
AS
BEGIN
   IF EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numPedido)
   BEGIN
      PRINT 'El pedido ya existe';
	  RETURN;
   END

   IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @cliente) OR 
      NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @repre) OR
	  NOT EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto)
   BEGIN
      PRINT 'Los datos no son válidos';
	  RETURN;
   END

   IF @cantidad <= 0
   BEGIN
      PRINT 'La cantidad no puede ser 0 o negativo';
	  RETURN;
   END

   DECLARE @stockValido INT;
   SELECT @stockValido = Stock FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto;

   IF @cantidad > @stockValido
   BEGIN
      PRINT 'No hay suficiente stock';
	  RETURN;
   END

   DECLARE @precio MONEY;
   DECLARE @importe MONEY;

   SELECT @precio = Precio FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto;
   SET @importe = @cantidad * @precio;

   BEGIN TRY
      -- Se inserta un pedido
      INSERT INTO Pedidos 
      VALUES (@numPedido, GETDATE(), @cliente, @repre, @fab, @producto, @cantidad, @importe);

      UPDATE Productos
      SET Stock = Stock - @cantidad
      WHERE Id_fab = @fab AND Id_producto = @producto;

   END TRY
   BEGIN CATCH 
      PRINT 'Error al actualizar datos';
	  RETURN;
   END CATCH;
END;

EXEC spu_realizar_pedido @numPedido = 113070, @cliente = 2000, 
@repre = 106, @fab = 'REI',
@producto = '2A44L', @cantidad = 20;

EXEC spu_realizar_pedido @numPedido = 113070, @cliente = 2117, 
@repre = 111, @fab = 'REI',
@producto = '2A44L', @cantidad = 20;

EXEC spu_realizar_pedido @numPedido = 113071, @cliente = 2117, 
@repre = 101, @fab = 'ACI',
@producto = '4100X', @cantidad = 20;

SELECT * FROM Productos
WHERE Id_fab = 'ACI' AND Id_producto = '4100x';

SELECT * FROM Pedidos;
SELECT * FROM Representantes;
