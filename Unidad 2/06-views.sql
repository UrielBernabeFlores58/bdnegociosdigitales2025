-- views
/* 
sintaxis
create view nombreVista
AS
select columnas
from tabla
where condicion
*/

use northwind
go

create view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description],picture
from Categories
go


-------
create or alter view VistaCategoriasTodas
AS
select CategoryID, CategoryName, [Description],picture
from Categories
go


select * from
VistaCategoriasTodas


select * from
VistaCategoriasTodas
where CategoryName = 'Beverages'



select * from Customers

/*
crear una vista que permita visualizar solamente los clientes de Mexico y Brazil
*/
GO
create or alter view ClientesLatinos
AS
select CustomerID,CompanyName, Country, City 
from Customers
where Country in ('Mexico','Brazil')
go

select * from ClientesLatinos


select companyname as cliente, City as ciudad, Country as pais from ClientesLatinos
where city = 'Sao Paulo'
order by 2 desc

-- join con vista y tabla
select  * from
Orders as o
inner join ClientesLatinos as vc
on vc.CustomerID = o.CustomerID


/* crear una vista que contenga los datos de todas las ordenes los produtos, 
categorias de produtos, empleados y clientes, en la orden calcular el importe */
go
create or alter view  VistaOrdenesdeCompra
as
select o.OrderID as [Numero de Orden], o.OrderDate as [Fecha de Orden], o.RequiredDate [Fecha de Requisicion],
concat (e.FirstName , ' ', e.LastName) as [Nombre empleado], cu.CompanyName as [Nombre del cliente], p.ProductName as [nombre producto]
, c.CategoryName as [Nombre de la categoria], od.UnitPrice as [Precio de venta], od.Quantity [cantidad vendida], (od.Quantity * od.UnitPrice) 
as [importe]
from 
Categories as c 
join Products as p
on c.CategoryID = p.CategoryID
join
[Order Details] as od
on od.ProductID = p.ProductID
join Orders as o
on o.OrderID = od.OrderID
join Customers as cu
on cu.CustomerID = o.CustomerID
join Employees as e
on e.EmployeeID = o.EmployeeID

go

select count(distinct [Numero de Orden]) as [Numero de Ordenes] from VistaOrdenesdeCompra


SELECT sum([cantidad vendida] * [Precio de venta] ) as [Ventas Totales] from VistaOrdenesdeCompra

go

SELECT sum(importe) as [Ventas Totales] from VistaOrdenesdeCompra
where year([Fecha de Orden]) between '1995' and '1996' 
go

create or alter view vista_ordenes_1995_1996
as
SELECT sum(importe) as [Ventas Totales], [Nombre del cliente] from VistaOrdenesdeCompra
where year([Fecha de Orden]) between '1995' and '1996' 
group by [Nombre del cliente]
having count (*)>2;


select * from vista_ordenes_1995_1996




















create schema rh

create table rh.tablarh
(
id int primary key,
nombre nvarchar (50)
)
-- vista horizontal
create or alter view rh.viewCategoriasProductos
as
 select c.CategoryID, CategoryName, p.ProductID, p.ProductName from 
Categories as c 
join
Products as p
on 
c.CategoryID = p.CategoryID;
go

select * from rh.viewCategoriasProductos

-- VISTA VERTICAL 

