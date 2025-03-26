# Left Join

## Ejercicio 4 de la Unidad 2


``` sql
-- EJEMPLO DE LEFT JOIN APLICADO

select * from products_new

/* carga full
*/

		insert into products_new
		select
			p.ProductID, p.ProductName,
			cu.CompanyName,  c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() as 'insert_date'
		from Products as p
		join Categories as c
		on p.CategoryID = c.CategoryID
		join [Order Details] as od
		on od.ProductID = p.ProductID
		join Orders as o
		on o.OrderID = od.OrderID
		join Customers as cu
		on cu.CustomerID = o.CustomerID

	
-- crear una tabla a partir de una consulta 

select
			p.ProductID, p.ProductName,
			cu.CompanyName,  c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() as 'inserted_date'
			into  products_new
		from Products as p
		join Categories as c
		on p.CategoryID = c.CategoryID
		join [Order Details] as od
		on od.ProductID = p.ProductID
		join Orders as o
		on o.OrderID = od.OrderID
		join Customers as cu
		on cu.CustomerID = o.CustomerID
		-- sin registro

		
select
			top 0 p.ProductID, p.ProductName,
			cu.CompanyName,  c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() as 'inserted_date'
			into  products_new
		from Products as p
		join Categories as c
		on p.CategoryID = c.CategoryID
		join [Order Details] as od
		on od.ProductID = p.ProductID
		join Orders as o
		on o.OrderID = od.OrderID
		join Customers as cu
		on cu.CustomerID = o.CustomerID

		-- cambio de nombre de columnas
				
select
			top 0 0 as [productbk], p.ProductID , p.ProductName as 'Producto',
			cu.CompanyName as 'Customer',  c.CategoryName as 'Category', od.UnitPrice, p.Discontinued, GETDATE() as 'inserted_date'
			into  products_new
		from Products as p
		join Categories as c
		on p.CategoryID = c.CategoryID
		join [Order Details] as od
		on od.ProductID = p.ProductID
		join Orders as o
		on o.OrderID = od.OrderID
		join Customers as cu
		on cu.CustomerID = o.CustomerID


			   	
		alter table products_new
		add constraint pk_products_new
		primary key (productbk) 
--- clave primaria despues
select -- Carga Full
			top 0  p.ProductID , p.ProductName as 'Producto',
			cu.CompanyName as 'Customer',  c.CategoryName as 'Category', od.UnitPrice, p.Discontinued, GETDATE() as 'inserted_date'
			into  products_new
		from Products as p
		join Categories as c
		on p.CategoryID = c.CategoryID
		join [Order Details] as od
		on od.ProductID = p.ProductID
		join Orders as o
		on o.OrderID = od.OrderID
		join Customers as cu
		on cu.CustomerID = o.CustomerID


		--
		drop table products_new
		-- crea
		alter table products_new 
		add productbk int not null identity (1,1)
		--- asigna primary
		alter table products_new
		add constraint pk_products_new
		primary key (productbk)

		--- hjadghasghjsaghjdsajhdgjsagdjhsagdhjsaghjsa



		insert into products_new (ProductID,Producto,Customer,Category,UnitPrice,Discontinued,inserted_date)
		select
			p.ProductID, p.ProductName,
			cu.CompanyName,  c.CategoryName, od.UnitPrice, p.Discontinued, GETDATE() as 'insert_date'
		from Products as p
		join Categories as c
		on p.CategoryID = c.CategoryID
		join [Order Details] as od
		on od.ProductID = p.ProductID
		join Orders as o
		on o.OrderID = od.OrderID
		join Customers as cu
		on cu.CustomerID = o.CustomerID
---inner 
--LEFT JOIN
SELECT 
	pn.ProductID,
	pn.Producto,
	pn.Customer,
	pn.Category,
	pn.UnitPrice,
	pn.Discontinued,
	pn.inserted_date,
	p.ProductID,
	p.ProductName
FROM Products as p
 JOIN products_new AS pn
ON p.ProductID = pn.ProductID
WHERE pn.ProductID IS NULL




--LEFT JOIN
SELECT 
	pn.ProductID,
	pn.Producto,
	pn.Customer,
	pn.Category,
	pn.UnitPrice,
	pn.Discontinued,
	pn.inserted_date,
	p.ProductID,
	p.ProductName
FROM Products as p
LEFT JOIN products_new AS pn
ON p.ProductID = pn.ProductID
WHERE pn.ProductID IS null

-- carga delta

insert into products_new (ProductID,producto,Customer,
Category,UnitPrice,Discontinued, inserted_date)
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
from Products as p 
left join 
Categories as c 
on p.CategoryID = c.CategoryID
left join [Order Details] as od
on od.ProductID = p.ProductID
left join Orders as o
on o.OrderID = od.OrderID
left join Customers as [cu]
on [cu].CustomerID = o.CustomerID
left join products_new as pn
on pn.ProductID = p.ProductID
where pn.ProductID is null

```