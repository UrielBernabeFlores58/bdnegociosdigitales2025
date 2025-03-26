# consultas avanzadas

## Ejercicio 3 de la Unidad 2

``` sql


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


/* 11 listar los clientes y la cantidad de pedidos
que han realizado */
select c.CompanyName as [Cliente] , count (*) as [Numero de ordenes] from
Customers as c
join
Orders as o
on c.CustomerID = O.CustomerID
group by c.CompanyName
order by [Numero de ordenes] desc

/*
12 obtener los empleados que han gestionado
pedidos enviados a alemania 
*/

select  distinct concat (e.FirstName, '  ' ,e.LastName ) as Nombre, o.ShipCountry from 
Employees as e
join
Orders as o
on e.EmployeeID = o.EmployeeID
where o.ShipCountry = 'Germany'


/* 13 listar los productos junto con el nombre del provedor 
y el pais de origen */

select p.ProductName as [Nombre Producto], s.CompanyName as [Provedor],
s.Country [Pais de Origeb] from
Products as p
join
Suppliers as s
on p.SupplierID = s.SupplierID
order by 1 asc


/* 14. obtener los pedidos agrupados por pais de envio*/

	select o.ShipCountry as [Pais de Envio], count (o.OrderID ) as [Numero de Ordenes]
 from	Orders as o
 group by o.ShipCountry
 order by 2 desc

	
-- 15 obtener los empleados y la cantidad de productos que contienen

select concat (e.FirstName ,' ', e.LastName) as [Nombre],
count (et.TerritoryID) as [Cantidad Territorio]
from
Employees as e
join
EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
group by e.FirstName, e.LastName


select concat (e.FirstName ,' ', e.LastName) as [Nombre],
count (et.TerritoryID) as [Cantidad Territorio],
t.TerritoryDescription as [Descripcion]
from
Employees as e
join
EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
join
Territories as t 
on et.TerritoryID = t.TerritoryID
group by e.FirstName, e.LastName, t.TerritoryDescription
order by 1 asc, t.TerritoryDescription desc

-- 16
select c.CategoryName as [Categoria], 
count (p.ProductID) as [Cantidad de productos]
from
Categories as c
join
Products as p
on c.CategoryID = p.ProductID
group by c.CategoryName
order by 2 desc

 -- 17 obtener la cantidad total de productos vendidos por proveedor 

	
	select s.CompanyName as [Provedor], sum (od.Quantity)
	as [total de venta]
	from
Suppliers as s
join
Products as p
on p.SupplierID = s.SupplierID
join 
[Order Details] as od
on od.ProductID = p.ProductID
group by s.CompanyName
order by 2 desc

-- 18. obtener la cantidad de pedidos enviados por cada empresa de transporte

select sp.CompanyName as 'Empresa de Transporte', count(o.OrderID) as Pedidos
from Orders as o
inner join Shippers as sp
on o.ShipVia = sp.ShipperID
group by sp.CompanyName

select * from Orders

select count(*) from Orders

select count(OrderID) from Orders

select count(ShipRegion) from Orders

-- Consultas Avanzadas

-- 19 Obtener los clientes que han realizado pedidos con mas de un producto

select c.CompanyName, count(distinct ProductID) as 'Numero de productos'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on od.OrderID = o.OrderID
group by c.CompanyName
order by 2 Desc


-- 20. Listar los empleados con la cantidad total de pedidos que han gestionado, y a que clientes les han vendido
-- agrupandolos por nombre completo y dentro de el con este nombre por cliente, ordenandolos por la cantidad mayor de pedidos.

select concat(e.FirstName, ' ', e.LastName) as Empleados, c.CompanyName as cliente ,count(o.OrderID) as 'Numero de ordenes'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
inner join Customers as c
on o.CustomerID = c.CustomerID
group by e.FirstName, e.LastName, c.CompanyName
order by Empleados asc, cliente

select concat(e.FirstName, ' ', e.LastName) as Empleados, count(o.OrderID) as 'Numero de ordenes'
from Orders as o
inner join Employees as e
on o.EmployeeID = e.EmployeeID
group by e.FirstName, e.LastName
order by Empleados asc

-- 21 listar las categorias con el total de ingresos generados por sus productos 

select c.CategoryName, sum (od.Quantity * od.UnitPrice) as Total from 
Categories as c
join 
Products as p
on c.CategoryID = p.CategoryID
join
[Order Details] as od
on p.ProductID = od.ProductID
group by c.CategoryName
-----------------------------------------------------------------------------------------------------------
select c.CategoryName,p.ProductName, sum (od.Quantity * od.UnitPrice) as Total from 
Categories as c
join 
Products as p
on c.CategoryID = p.CategoryID
join
[Order Details] as od
on p.ProductID = od.ProductID
group by c.CategoryName, p.ProductName
order by c.CategoryName 


--22 listar los clientes con el total gastado en pedidos

select distinct c.CompanyName as Clientes, sum (od.UnitPrice * od.Quantity) as 'Total Gastado'  
from  Customers as c
join Orders as o
on c.CustomerID = o.CustomerID
join [Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName


--23 listar los pedidos realizados entre el 1 de enero de 1997 y el 30 de junio de 1997 y mostrar
-- el total de dinero 

select o.OrderID, o.OrderDate, sum (od.UnitPrice * od.UnitPrice) as [Total]
from 
Orders as o
join
[Order Details] as od
on od.OrderID = o.OrderID
where o.OrderDate between '1997-01-01' and '1997-06-30'
group by o.OrderDate, o.OrderID

/* listar los productos con las categorias beverags, seafood, confections*/
select p.ProductName, c.CategoryName from 
Products as p
join
Categories as c
on p.CategoryID = c.CategoryID
where c.CategoryName in ('beverags' , 'seafood', 'confections')



-- 25 listar los clientes ubicados en alemania y que hayasn realizado pedidos antes del 1 de enero de 1997

select c.CompanyName as Cliente, o.OrderDate as [Pedido], c.Country from 
Customers as c
join 
Orders as o
on 
c.CustomerID = o.CustomerID
where o.OrderDate < '1997-01-01' 
and c.Country = 'Germany'
group by c.CompanyName, o.OrderDate, c.Country

-- 26 listar los clientes qye han realizado pedidos con un total entre 500 y 2000

select c.CompanyName as Cliente, sum (od.Quantity * od.UnitPrice) as 'Total' from 
Customers as c
join
Orders as o
on c.CustomerID = o.CustomerID
join
[Order Details] as od
on o.OrderID = od.OrderID
group by c.CompanyName
having sum (od.Quantity * od.UnitPrice) between '500' and '2000'


-- left join , rigth join, full join, cross join

/* practica de utilizacion de left join

seleccionar los datos qyuese van a utilizar para insertar en la tabla 
products_new

product id, productname, customer ciente, category(name), unitprice , discontinued y insterted_date
*/
select c.categoriaid, c.nombre, p.categoriaid, p.productoid, p.nombre
from Categorias as c
inner join Productos as p
on p.categoriaid = c.categoriaid

select c.categoriaid, c.nombre, p.categoriaid, p.productoid, p.nombre
from Categorias as c
left join Productos as p
on p.categoriaid = c.categoriaid

select c.categoriaid, c.nombre, p.categoriaid, p.productoid, p.nombre
from Productos as p
left join Categorias as c
on p.categoriaid = c.categoriaid


```