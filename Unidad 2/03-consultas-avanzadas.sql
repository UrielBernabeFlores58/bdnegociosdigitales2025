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


--cdccdcdccdcdcdccdcdcdcdcdcdcdcdcdccdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd

