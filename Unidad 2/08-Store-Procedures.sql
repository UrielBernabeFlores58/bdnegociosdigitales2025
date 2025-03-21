--- crear un store procedure para seleccionar todos los clientes


create or alter procedure spu_mostrar_clientes
as
	 begin 
select * from Customers
end;
go  

exec spu_mostrar_clientes
go

-- crear un sp que muestre los clientes por pais
-- parametros de entrada

create or alter proc spu_customersporpais
-- parametros 
@pais  nvarchar(15), -- parametro de entrada
@pais2 nvarchar(16)
	as
	begin
	select * from Customers
	where Country in (@pais, @pais2);
	end;


exec spu_customersporpais 'Spain', 'Germany'

-- o

declare @p1 nvarchar(15) = 'spain';
declare @p2 nvarchar(15) = 'germany';

exec spu_customersporpais @p1, @p2;
go
/*
-- crea un reporte que permita visualizar los datos de compra de un determinado cliente
en un rango de fechad mostrando el mosto total de compras por un producto mediante un sp
*/

create or alter proc spu_informe_ventas_clientes
-- parametros
@nombre nvarchar(40), -- parametro de entrada con valor por default
@fechaInicial datetime,
@fechaFinal datetime
as 
begin
select [nombre producto], sum (importe) as [Monto Total] from VistaOrdenesdeCompra
where [Nombre del cliente] = @nombre
and [Fecha de Orden] between @fechaInicial and @fechaFinal
group by [nombre producto], [Nombre del cliente]
end
go



create or alter proc spu_informe_ventas_clientes
-- parametros
@nombre nvarchar(40) = 'Berglunds snabbköp', -- parametro de entrada con valor por default
@fechaInicial datetime,
@fechaFinal datetime
as 
begin
select [nombre producto], [Nombre del cliente] ,sum (importe) as [Monto Total] from VistaOrdenesdeCompra
where [Nombre del cliente] = @nombre
and [Fecha de Orden] between @fechaInicial and @fechaFinal
group by [nombre producto], [Nombre del cliente]
end
go

select GETDATE()

-- ejecucion de un store con parametros de entrada
exec spu_informe_ventas_clientes 'Berglunds snabbköp', '1996-07-04', '1997-01-01'

-- ejecucion de un store con parametros en diferente posicion
exec spu_informe_ventas_clientes @FechaInicial = '1996-07-04',
							@FechaFinal ='1997-01-01'

-- ejecucion de un store con parametros de entrada con un campo que tiene un valor por default
exec spu_informe_ventas_clientes @FechaFinal ='1997-01-01',@nombre = 'Berglunds snabbköp',
@FechaInicial = '1996-07-04'


-- store procedure con parametros de salida
create or alter proc spu_obtener_numero_clientes
@customerid nchar(5),--parametro de entrada,
@totalCustomers int output -- parametro de  salida
as 
begin
select @totalCustomers = count(*) from Customers
where CustomerID = @customerid;
end;
go



--declare @numero as int;
declare @numero int 
exec spu_obtener_numero_clientes 'ANATR',
@totalCustomers = @numero output;
print @numero;
go



-- STORE PROCEDURE QUE PERMITA SABER SI UN ALUMNO APROBO O REPROBO

create or alter proc spu_comparar_calificacion
@calificacion decimal(10,2) --parametro de entrada
AS
begin
	if @calificacion>=0 and @calificacion <=10
		begin
			if @calificacion>=8
				print 'La calificacion es aprobatoria'
			else 
				print 'La calificacion es reprobatoria'
		end
			else 
				print 'Calificacion no valida'
	end;
go	


exec spu_comparar_calificacion @calificacion =  



-- crear un sp que permita verificar si un cliente existe antes de devolver su informacion

		create or alter proc spu_obtener_cliente_siexiste
		@numeroCliente nchar(5)
		as
		begin
				if exists(select 1 from Customers where CustomerID = @numeroCliente)
				select * from Customers where CustomerID = @numeroCliente;
				else
					print 'El cliente no existe'
		end;
		go

select 1 from Customers where CustomerID = 'ANATR'


exec spu_obtener_cliente_siexiste @numeroCliente = 'Arout'

-- crear un store procedure que permita insertar un cliente
-- pero se debe verificar primero que no exista




create or alter proc spu_agregar_cliente
	@id nchar(5),
	@nombre varchar(40),
	@city nvarchar(15) = 'San Miguel'
	as
	begin
	if exists (select 1 from Customers where CustomerID = @id)
		begin
		print ('El Cliente ya existe')
		return 1
	end
	insert into Customers (CustomerID, CompanyName)
	values (@id,@nombre);
	print ('Cliente insertado exitosamente');
	return 0;
end;
	go

	-- exec spu_agregar_cliente 'ORDEP', 'Industrias Corporativas SACV', 'San Miguel'
execute spu_agregar_cliente 'AlFKI', 'Patito de Hule'
execute spu_agregar_cliente 'AlFKC', 'Patito de Hule'


create or alter procedure spu_agregar_cliente_try_catch
	@id nchar(5),
	@nombre nvarchar(40),
	@city nvarchar(15) = 'San Miguel'
AS
begin
	begin try
	insert into Customers(CustomerID, CompanyName)
	values(@id,@nombre);
	print('Cliente insertado exitosamente');
	end try
	begin catch
		print('El cliente ya existe');
	end catch
end;

exec spu_agregar_cliente 'ALFKD', 'Muñeca Vieja'
go
create or alter procedure spu_ciclo_imprimir
	@numero int
AS
begin

	if  @numero<=0
	begin
		print('El numero no puede ser 0 o negativo');
		return
	end
----------
	declare @i int
	SET @i = 1
	while(@i<=@numero)
	begin
	print('Numero '+ @i);
	end
end;
go

exec  spu_ciclo_imprimir

-- Imprimir el numero de veces que indique el usuario
go
create or alter procedure spu_ciclo_imprimir
	@numero int
AS
begin

	if  @numero<=0
	begin
		print('El numero no puede ser 0 o negativo');
		return
	end
----------
	declare @i int
	SET @i = 1
	while(@i<=@numero)
	begin
	print concat('Numero ', @i);
	SET @i = @i+1
	end
end;
go

exec spu_ciclo_imprimir @numero = 100





-- Realizar un pedido con un Store Procedure
-- Validar que el pedido no exista
-- Validar que el cliente, que el empleado y producto exista
-- La cantidad a vender, debe ser validada, que haya suficiente stock del producto
-- Insertar el pedido y calcular el importe (multiplicando el precio del producto
-- por la cantidad vendida)
-- Actualizar el stock del producto(restando el stock menos la cantidad vendida)


use BDEJEMPLO2
select * from Pedidos
go
create or alter procedure spu_pedido_submit
@numpedido int,
@cliente int,
@rep int,
@fab char(3),
@producto char(5),
@cantidad int
AS
begin
	if exists (select 1 from Pedidos where Num_Pedido = @numpedido)
	begin
		print('El pedido ya existe');
		return
	end	

	if not exists (select 1 from Clientes where Num_Cli = @cliente) or
	   not exists (select 1 from Representantes where Num_Empl = @rep) or
	   not exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto)
	begin
		print('Los datos no son validos')
		return
	end

	if @cantidad <=0 
	begin
		print ('La cantidad no puede ser 0 o negativo')
		return;
	end
	declare @stockValido int
	select @stockValido = stock from Productos where Id_fab = @fab and Id_producto = @producto
		if @cantidad > @stockValido
		begin
		print 'No hay Suficiente Stock'
		return;
	end
	
	declare @precio money, @importe money

	select @precio =Precio from Productos where Id_fab = @fab and Id_producto = @producto
	set @importe = @cantidad * @precio	
	
	begin try -- si no entra se va al print si el que sigue
	-- se inserto un pedido
	insert into Pedidos
	values (@numpedido, getdate(), @cliente, @rep, @fab, @producto, @cantidad, @importe)
	update Productos
	set Stock = Stock - @cantidad
		where Id_fab =  @fab and Id_producto = @producto
	end try
		begin catch
			print 'Error al actualizar datos'
			return;
	end catch
	
end
--(Num_Pedido, Cliente, Rep, Fab, Producto, Cantidad)
go

execute spu_pedido_submit @numpedido = 112961, @cliente = 2117, @rep =106, 
@fab ='REI', @producto ='2A44L', @cantidad =20

execute spu_pedido_submit @numpedido = 11370, @cliente = 2117, @rep =111, 
@fab ='REI', @producto ='2A44L', @cantidad =20

execute spu_pedido_submit @numpedido = 11370, @cliente = 2117, @rep =101, 
@fab ='ACI', @producto ='4100X', @cantidad =20

select * from Productos
where Id_fab = 'ACI' and Id_producto = '4100x'




/*






create or alter procedure sp_datos_de_compra
@NumerodeOrden int,
@OrdenFecha datetime ,
@Total money
as
 select * from VistaOrdenesdeCompra
 where year ([Fecha de Orden]) in (1996,1998)
 

 exec sp_datos_de_compra @NumerodeOrden  = 10250,
 @OrdenFecha = 1998, @Total = 26.00
 drop procedure sp_datos_de_compra

  select [Nombre del cliente] from VistaOrdenesdeCompra
  order by 1 asc
GO

*/ 

-- examples Registrar un nuevo cliente
CREATE OR ALTER PROCEDURE spu_cliente_insert
    @num_cli INT,
    @empresa VARCHAR(20),
    @rep_cli INT,
    @limite_credito MONEY
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @num_cli)
    BEGIN
        PRINT 'El cliente ya existe'
        RETURN
    END

    INSERT INTO Clientes (Num_Cli, Empresa, Rep_Cli, Limite_Credito)
    VALUES (@num_cli, @empresa, @rep_cli, @limite_credito)

    PRINT 'Cliente registrado exitosamente'
END

-- 2 Este procedimiento actualiza el límite de crédito de un cliente existente.
CREATE OR ALTER PROCEDURE spu_cliente_update_credito
    @num_cli INT,
    @nuevo_limite MONEY
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @num_cli)
    BEGIN
        PRINT 'El cliente no existe'
        RETURN
    END

    UPDATE Clientes
    SET Limite_Credito = @nuevo_limite
    WHERE Num_Cli = @num_cli

    PRINT 'Límite de crédito actualizado'
END

--3 Este procedimiento elimina un cliente si no tiene pedidos.
CREATE OR ALTER PROCEDURE spu_cliente_delete
    @num_cli INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @num_cli)
    BEGIN
        PRINT 'El cliente no existe'
        RETURN
    END

    IF EXISTS (SELECT 1 FROM Pedidos WHERE Cliente = @num_cli)
    BEGIN
        PRINT 'No se puede eliminar el cliente porque tiene pedidos registrados'
        RETURN
    END

    DELETE FROM Clientes WHERE Num_Cli = @num_cli

    PRINT 'Cliente eliminado correctamente'
END

--4 Este procedimiento es similar al que compartiste, pero optimizado.
CREATE OR ALTER PROCEDURE spu_pedido_insert
    @numpedido INT,
    @cliente INT,
    @rep INT,
    @fab CHAR(3),
    @producto CHAR(5),
    @cantidad INT
AS
BEGIN
    DECLARE @stock INT, @precio MONEY, @importe MONEY

    IF EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido ya existe'
        RETURN
    END

    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE Num_Cli = @cliente)
        OR NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @rep)
        OR NOT EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto)
    BEGIN
        PRINT 'Datos inválidos'
        RETURN
    END

    IF @cantidad <= 0 
    BEGIN
        PRINT 'Cantidad inválida'
        RETURN
    END

    SELECT @stock = Stock, @precio = Precio FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto

    IF @cantidad > @stock
    BEGIN
        PRINT 'Stock insuficiente'
        RETURN
    END

    SET @importe = @cantidad * @precio

    BEGIN TRANSACTION
    INSERT INTO Pedidos VALUES (@numpedido, GETDATE(), @cliente, @rep, @fab, @producto, @cantidad, @importe)
    UPDATE Productos SET Stock = Stock - @cantidad WHERE Id_fab = @fab AND Id_producto = @producto
    COMMIT TRANSACTION

    PRINT 'Pedido registrado correctamente'
END
--5 Este procedimiento permite modificar la cantidad de un producto en un pedido
CREATE OR ALTER PROCEDURE spu_pedido_update_cantidad
    @numpedido INT,
    @cantidad_nueva INT
AS
BEGIN
    DECLARE @cantidad_actual INT, @producto CHAR(5), @fab CHAR(3), @stock INT, @precio MONEY, @importe MONEY

    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe'
        RETURN
    END

    SELECT @producto = Producto, @fab = Fab, @cantidad_actual = Cantidad FROM Pedidos WHERE Num_Pedido = @numpedido
    SELECT @stock = Stock, @precio = Precio FROM Productos WHERE Id_fab = @fab AND Id_producto = @producto

    IF @cantidad_nueva > (@stock + @cantidad_actual)
    BEGIN
        PRINT 'Stock insuficiente'
        RETURN
    END

    SET @importe = @cantidad_nueva * @precio

    BEGIN TRANSACTION
    UPDATE Pedidos SET Cantidad = @cantidad_nueva, Importe = @importe WHERE Num_Pedido = @numpedido
    UPDATE Productos SET Stock = Stock + @cantidad_actual - @cantidad_nueva WHERE Id_fab = @fab AND Id_producto = @producto
    COMMIT TRANSACTION

    PRINT 'Cantidad de pedido actualizada'
END

--6 Este procedimiento elimina un pedido y regresa el stock.
CREATE OR ALTER PROCEDURE spu_pedido_delete
    @numpedido INT
AS
BEGIN
    DECLARE @cantidad INT, @producto CHAR(5), @fab CHAR(3)

    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe'
        RETURN
    END

    SELECT @producto = Producto, @fab = Fab, @cantidad = Cantidad FROM Pedidos WHERE Num_Pedido = @numpedido

    BEGIN TRANSACTION
    DELETE FROM Pedidos WHERE Num_Pedido = @numpedido
    UPDATE Productos SET Stock = Stock + @cantidad WHERE Id_fab = @fab AND Id_producto = @producto
    COMMIT TRANSACTION

    PRINT 'Pedido eliminado y stock restaurado'
END

--7 Este procedimiento registra un producto.	
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
        PRINT 'El producto ya existe'
        RETURN
    END

    INSERT INTO Productos VALUES (@id_fab, @id_producto, @descripcion, @precio, @stock)

    PRINT 'Producto agregado exitosamente'
END

--8 Este procedimiento cambia el precio de un producto.
CREATE OR ALTER PROCEDURE spu_producto_update_precio
    @id_fab CHAR(3),
    @id_producto CHAR(5),
    @nuevo_precio MONEY
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE Id_fab = @id_fab AND Id_producto = @id_producto)
    BEGIN
        PRINT 'El producto no existe'
        RETURN
    END

    UPDATE Productos
    SET Precio = @nuevo_precio
    WHERE Id_fab = @id_fab AND Id_producto = @id_producto

    PRINT 'Precio actualizado'
END


---------------------------------------------------------------------------------

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
    DECLARE @cantidad_actual INT, @producto CHAR(5), @fab CHAR(3)

    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe'
        RETURN
    END

    -- Obtener datos del pedido
    SELECT @producto = Producto, @fab = Fab, @cantidad_actual = Cantidad
    FROM Pedidos WHERE Num_Pedido = @numpedido

    -- Validar que la cantidad devuelta no sea mayor a la cantidad original
    IF @cantidad_devuelta > @cantidad_actual OR @cantidad_devuelta <= 0
    BEGIN
        PRINT 'Cantidad inválida para devolución'
        RETURN
    END

    -- Transacción para actualizar el pedido y restaurar el stock
    BEGIN TRANSACTION
    UPDATE Pedidos SET Cantidad = Cantidad - @cantidad_devuelta WHERE Num_Pedido = @numpedido
    UPDATE Productos SET Stock = Stock + @cantidad_devuelta WHERE Id_fab = @fab AND Id_producto = @producto
    COMMIT TRANSACTION

    PRINT 'Devolución procesada correctamente'
END
/*
--2 Aplicar un descuento a un pedido
Validaciones:
El pedido debe existir
El descuento no puede hacer que el importe sea negativo*/

CREATE OR ALTER PROCEDURE spu_pedido_descuento
    @numpedido INT,
    @descuento MONEY
AS
BEGIN
    DECLARE @importe_actual MONEY

    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe'
        RETURN
    END

    -- Obtener importe actual
    SELECT @importe_actual = Importe FROM Pedidos WHERE Num_Pedido = @numpedido

    -- Validar que el descuento no haga que el importe sea negativo
    IF @descuento >= @importe_actual OR @descuento < 0
    BEGIN
        PRINT 'Descuento inválido'
        RETURN
    END

    -- Aplicar descuento
    UPDATE Pedidos SET Importe = Importe - @descuento WHERE Num_Pedido = @numpedido

    PRINT 'Descuento aplicado correctamente'
END

/*
3--Transferir un pedido a otro representante
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
        PRINT 'El pedido no existe'
        RETURN
    END

    -- Validar que el nuevo representante exista
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @nuevo_rep)
    BEGIN
        PRINT 'El representante no existe'
        RETURN
    END

    -- Actualizar el representante del pedido
    UPDATE Pedidos SET Rep = @nuevo_rep WHERE Num_Pedido = @numpedido

    PRINT 'Pedido transferido correctamente'
END


/*
--4 Cancelar un pedido
Validaciones:
 El pedido debe existir
 Se debe restaurar el stock
*/
CREATE OR ALTER PROCEDURE spu_pedido_cancelar
    @numpedido INT
AS
BEGIN
    DECLARE @cantidad INT, @producto CHAR(5), @fab CHAR(3)

    -- Validar que el pedido exista
    IF NOT EXISTS (SELECT 1 FROM Pedidos WHERE Num_Pedido = @numpedido)
    BEGIN
        PRINT 'El pedido no existe'
        RETURN
    END

    -- Obtener datos del pedido
    SELECT @producto = Producto, @fab = Fab, @cantidad = Cantidad FROM Pedidos WHERE Num_Pedido = @numpedido

    -- Transacción para cancelar el pedido y restaurar stock
    BEGIN TRANSACTION
    DELETE FROM Pedidos WHERE Num_Pedido = @numpedido
    UPDATE Productos SET Stock = Stock + @cantidad WHERE Id_fab = @fab AND Id_producto = @producto
    COMMIT TRANSACTION

    PRINT 'Pedido cancelado correctamente'
END


/*
--5 Verificar si un representante ha cumplido su cuota
Validaciones:
El representante debe existir
 Se deben sumar los importes de sus pedidos
*/
CREATE OR ALTER PROCEDURE spu_rep_verificar_cuota
    @rep INT
AS
BEGIN
    DECLARE @cuota MONEY, @ventas MONEY

    -- Validar que el representante exista
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @rep)
    BEGIN
        PRINT 'El representante no existe'
        RETURN
    END

    -- Obtener cuota y ventas
    SELECT @cuota = Cuota FROM Representantes WHERE Num_Empl = @rep
    SELECT @ventas = ISNULL(SUM(Importe), 0) FROM Pedidos WHERE Rep = @rep

    -- Validar si cumplió la cuota
    IF @ventas >= @cuota
        PRINT 'El representante ha cumplido su cuota'
    ELSE
        PRINT 'El representante no ha cumplido su cuota'
END


/*
--6 Consultar los productos con menos stock
*/

CREATE OR ALTER PROCEDURE spu_productos_bajo_stock
    @limite INT
AS
BEGIN
    SELECT * FROM Productos WHERE Stock < @limite
END


/*
--7  Cambiar el jefe de una oficina
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
        PRINT 'La oficina no existe'
        RETURN
    END

    -- Validar que el nuevo jefe exista
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @nuevo_jefe)
    BEGIN
        PRINT 'El representante no existe'
        RETURN
    END

    -- Actualizar jefe
    UPDATE Oficinas SET Jef = @nuevo_jefe WHERE Oficina = @oficina

    PRINT 'Jefe actualizado correctamente'
END


/*
--8 Generar reporte de ventas de un representante
*/

 CREATE OR ALTER PROCEDURE spu_reporte_ventas_rep
    @rep INT
AS
BEGIN
    -- Validar que el representante exista
    IF NOT EXISTS (SELECT 1 FROM Representantes WHERE Num_Empl = @rep)
    BEGIN
        PRINT 'El representante no existe'
        RETURN
    END

    -- Generar reporte de ventas
    SELECT Num_Pedido, Fecha_Pedido, Cliente, Producto, Cantidad, Importe
    FROM Pedidos WHERE Rep = @rep
    ORDER BY Fecha_Pedido DESC
END


/* 
--9
*/
*
Generar un informe de desempeño de representantes
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
select * from Representantes
go
CREATE OR ALTER PROCEDURE spu_reporte_desempeño
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
    SELECT @cuota = Cuota 
    FROM Representantes 
    WHERE Num_Empl = @numempleado;
	
    -- Calcular el total de pedidos gestionados
    SELECT @totalPedidos = COUNT(*)
    FROM Pedidos
    WHERE Rep = @numempleado;

    -- Calcular la cantidad total de productos vendidos
    SELECT @totalProductosVendidos = SUM(Cantidad)
    FROM Pedidos
    WHERE Rep = @numempleado;

    -- Calcular el monto total de ventas generadas
    SELECT @totalVentas = SUM(Importe)
    FROM Pedidos
    WHERE Rep = @numempleado;

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

	begin try
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
		commit transaction
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		RAISERROR('Error al generar el reporte de desempeño', 16, 1);
	END CATCH
end
go
select * from Representantes
SELECT * FROM Representantes WHERE Cuota IS NULL OR Ventas IS NULL;

--	Prueba: Representante con ventas
EXEC spu_reporte_desempeño @numempleado = 104;
rollback transaction

select * from Pedidos
select sum(Importe) from Pedidos
where Rep = 104
-- 58633,00