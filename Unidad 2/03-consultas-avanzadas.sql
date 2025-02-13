/* 07/02/2025
 JOINS
 INNER 
 LEFT
 RIGTH
 CROSS
 ESTRUCTURA
 SELECT * FROM 
 TABLA 1
 INNER 
 TABLA 2
 OM (PRIMARE KEY) = (FOREING KEY)

*/

use Northwind
-- seleccionar las categorias avanzadas 

select * from 
Categories -- izquierda
inner join
Products
on Categories.CategoryID = Products.CategoryID

-- CDCDCDCDCDCDCDCDCDCDCDCDCCDCDCDCDCDCDCDCDCDDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDDCDCDCDCDCDDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDDCCDCCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDC

select Categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice from 
Categories -- izquierda
inner join
Products
on Categories.CategoryID = Products.CategoryID

-- mejor forma, usando alias de tabla
select c.CategoryID as [numero de categoria], CategoryName as 'Nombre de Categoria',
ProductName as 'Nombre de Producto' , UnitsInStock as 'Unidades en existemcia', UnitPrice as 
'Precio' from 
Categories as c -- izquierda
inner join
Products as p
on c.CategoryID = p.CategoryID

/* seleccionar los productos de la categoria beverages y condiments 
donde la existencia este entre 18 y 30 */
select  ProductName 'Producto', CategoryName as 'Categoria'
, UnitsInStock as 'Existencia' from
Categories as ca
inner join
Products as p
on p.CategoryID = ca.CategoryID
where ca.CategoryName in ('beverages', 'condiments')
and p.UnitsInStock between 18 and 30
order by p.UnitsInStock asc

/*
seleccionar los productos y sus importes realizados de marzo a junio de 1996
mostrando la fecha de la orden el id de producto y el importe 
*/

select o.OrderID, o.OrderDate, od.ProductID, (od.UnitPrice * od.Quantity) as [Importe]
from 
Orders as o
join
[Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31'



select concat('$', ' ', sum(od.Quantity * od.UnitPrice)) as importe
from Orders as o
join
[Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-01' and '1996-10-31'




/* cdccdcdccdcdcdccdcdcdcdcdcdcdcdcdccdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd

CONSULTAS BASICAS CON INNER JOIN

OBTENER LOS NOMBRES DE LOS CLIENTES Y LOS PAISS A LOS QUE SE ENVIARON SUS PEDIDOS
*/

	select c.CompanyName as 'No,', o.ShipCountry as 'Pais de Envio' from
	Customers as c
	inner join
	Orders as o
	on c.CustomerID = o.CustomerID
	order by 2 desc

-- obtener los productos y sus respectivos proveedores

	select p.ProductName as 'Producto', s.CompanyName as 'Provedor' from 
	Products as p
	join 
	Suppliers as s
	on s.SupplierID = p.SupplierID


	-- obtener los pedidos y los empleados que los gestionaron

	select o.OrderID as 'Orden', concat (e.FirstName ,' ' , e.LastName) as 'Empleado'  from
	Orders as o
	join
	Employees as e
	on e.EmployeeID = o.EmployeeID  
	
	-- 4 lsitar los productos junto con sus precios  y la categoria a la que pertenecen
	select p.ProductName, p.UnitPrice, c.CategoryID from
	Products as p
	join 
	Categories as c
	on p.CategoryID = c.CategoryID

	-- 5 obtener el nombre del cliente, numero de orden y la fecha de orden
		select c.ContactName, o.OrderID, o.OrderDate from 
		Customers as c
		join
		Orders as o
		on c.CustomerID = o.CustomerID

	--6 listar las ordenes mostrando el numero de orden, el nombre del producto y la cantidad que se vendio
		-- normal
		select od.OrderID, p.ProductName, od.Quantity as 'Cantidad vendida' from 
		[Order Details] as od
		join 
		Products as p
		on od.ProductID = p.ProductID

		-- cantidad ordenada de la mas vendida
		select od.OrderID, p.ProductName, od.Quantity as 'Cantidad vendida' from 
		[Order Details] as od
		join 
		Products as p
		on od.ProductID = p.ProductID
		order by od.Quantity desc
		
		-- top 5 mas vendidas
		select top 5 od.OrderID, p.ProductName, od.Quantity as 'Cantidad vendida' from 
		[Order Details] as od
		join 
		Products as p
		on od.ProductID = p.ProductID
		order by od.Quantity desc

		
		select od.OrderID, p.ProductName, od.Quantity as 'Cantidad vendida' from 
		[Order Details] as od
		join 
		Products as p
		on od.ProductID = p.ProductID
		where od.OrderID = 1103
		order by od.Quantity desc
		

		select od.OrderID, 
		count(*) as 'cantidad de productos vendidos'
		from 
		[Order Details] as od
		join 
		Products as p
		on od.ProductID = p.ProductID
		group by od.OrderID
		order by od.Quantity desc


		select * from 
		[Order Details] as od
		where od.OrderID = 11077
		

	 -- 7. obtener los empleados y sus respectivos jefxes
		select concat (e1.FirstName, '' , e1.LastName) as Empleado, concat(j1.FirstName, '', j1.LastName ) as [Jefe] from
		Employees as e1
		join
		Employees as j1
		on e1.ReportsTo = j1.EmployeeID

		-- listar los pedidos y el nombre de la empresa de transporte utilizada
		select o.OrderID, s.CompanyName from 
		Shippers as s
		join 
		Orders as o
		on o.ShipVia = s.ShipperID

/* consultas intermedias de inner join

obstener la cantidad total de productos vendidos por categoria
*/

select  sum (Quantity) from [Order Details]

select c.CategoryName 'Nombre Categoria',  sum (Quantity) as 'Productos Vendidos' from 
Categories as c
join
Products as p
on c.CategoryID = p.CategoryID
join
[Order Details] as od
on od.ProductID = p.ProductID
group by c.CategoryName
order by c.CategoryName


-- onbtener el total de ventas por empleado

select concat(e.FirstName,'-', e.LastName ) as Nombre,
sum((od.Quantity * od.UnitPrice)-(od.Quantity * od.UnitPrice) * od.Discount) 
as 'Total Vendido' from 
[Order Details] as od
join
Orders as o
on od.OrderID = o.OrderID
join 
Employees as e
on  o.EmployeeID = e.EmployeeID
group by e.FirstName, e.LastName


select  e.FirstName,count (o.OrderID )from 
[Order Details] as od
join
Orders as o
on od.OrderID = o.OrderID
join 
Employees as e
on  o.EmployeeID = e.EmployeeID
where e.EmployeeID =1
group by e.FirstName
