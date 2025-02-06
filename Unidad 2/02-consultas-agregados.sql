/* consultas de agregado 
solo devuelven un solo registrp

sum, avg, count, count(*), mas y min

cuantos clientes tengo
*/

select count(*) as [Numero de Clientes] from Customers

-- cuantas regiones hay
select count(Region) as [Regiones] from Customers

-- VERSION 2
select count (distinct region) as [Regiones]
from Customers
where Region is not null


select count(*) from Orders
select count(ShipRegion) from Orders -- count no cuenta nulos (null)

/*
selecciona el precio bajo de los productos
*/


	select min(UnitPrice), max (UnitPrice) ,
	avg(UnitsInStock) 
	from Products
-- SELECCIONAR CUANTOS PEDIDOS EXISTEN

	select count(OrderID) from Orders

-- CALCULA EL TOTAL DE DINERO VENDIDO 

	select sum(UnitPrice * Quantity) from [Order Details]
	
	select sum(UnitPrice * Quantity- (UnitPrice * Quantity * Discount)) as Total from [Order Details]
	
-- CALCULA EL TOTAL DE UNIDADRS EN STOCK DE TODOS LOS PRODUCTOS


select sum(UnitsInStock) as [Total de unidades] from Products
/* 
---
tema group by 

sleccionar el numero de productos por categoria 
*/

select * from Products

select CategoryID, count(*) as 'Numero de producto'
from Products
group by CategoryID




select Categories.CategoryName, 
count(*) as [Numero de Productos]
from Categories 
inner join Products as p
on Categories.CategoryID = p.CategoryID /*tambien se pude poner Categories.CategoryID*/
group by Categories.CategoryName 


-- CALCULAR EL PRECIO PROMEDIO DE LOS PRODUCTOS POR CADA CATEGORIA

select CategoryID, avg(UnitPrice) as 'Precio Promedio' from Products
group by CategoryID

--seleccionar el numero de pedidos realizados por cada empleado por el ultimo trimestre

select EmployeeID, count(*)as 'Numero de Pedidos' from Orders
group by EmployeeID

select EmployeeID, count(*) as 'Pedidos Realizados' from Orders
where OrderDate between '1996-10-01' and '1996-12-31'
Group by EmployeeID
-- seleccionar el numero de pedidos realizados por cada empleado

select EmployeeID as Empleado,count(OrderID) as [Pedidos realizados por cada empleado] from Orders
group by EmployeeID

-- seleccionar la suma total de unidades vendidas por cada producto 

select OrderID,ProductID, sum(Quantity) as [Unidades Vendidas] from [Order Details]
group by OrderID,ProductID
order by 2 desc

/*
seleccionar el numero de productos por categoria, 
pero solo aquellos que tengas mas de 10 productos
*/

-- paso 1
select * from Products

-- paso 2
select CategoryID from Products
where CategoryID in (2,4,8)
order by CategoryID asc

-- paso 3

select CategoryID, sum(UnitsInStock) from Products
where CategoryID in (2,4,8)
group by CategoryID
having count(*)>10
order by CategoryID asc


/* listar las ordenes agrupadas por empleado, pero que solo muestre 
aquellos que hayan gestionado mas de 10 pedidos */

select * from Orders


select OrderID, EmployeeID from Orders
group by OrderID
having count (*)>10





