use Northwind;
/*
1.    Productos con categoría 1, 3 o 5
*/
select ProductName, CategoryID  from Products
where CategoryID IN (1,3,5);


/*
2.    Clientes de México, Brasil o Argentina
*/
Select * from Customers
where Country in ('Mexico', 'Brazil', 'Argentina');

/*
3.    Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
*/
Select * from Orders
where ShipVia in (1,2,3) and Freight >50;

/*
4.    Empleados que trabajan en Londres, Seattle o Buenos Aires
*/

select *
from Employees
where City IN ('London', 'Seattle', 'Buenos Aires')

/*
5.    Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
*/
select *
from Orders
where Freight <= 100
and ShipCountry IN('France', 'Germany')

/*
6.    Productos con categoría 2, 4 o 6 y que NO estén descontinuados
*/
select *
from Products
where CategoryID IN(2,4,6)
and Discontinued in (0)


 /*
7.    Clientes que NO son de Alemania, Reino Unido ni Canadá*/
select *
from Customers
where not Country IN ('Germany', 'UK', 'Canada')

/*
8.    Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canadá */
select *
from Orders
where ShipVia In (2,3)
and not ShipCountry In ('Canada','USA')

/*
9.    Empleados que trabajan en 'London' o 'Seattle' y fueron contratados después de 1995*/

select *
from Employees
where City IN ('London', 'Seattle')
and year(HireDate) = 1995


/*
10.    Productos de categorías 1, 3 o 5 con stock mayor a 50 y que NO están descontinuados
*/
select *
from Products
where CategoryID in (1,3,5)
and (UnitsInStock >= 50)
and Discontinued in (0)



