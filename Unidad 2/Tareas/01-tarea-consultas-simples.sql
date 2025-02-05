use Northwind;
/*
1.    Productos con categor�a 1, 3 o 5
*/
select ProductName, CategoryID  from Products
where CategoryID IN (1,3,5);


/*
2.    Clientes de M�xico, Brasil o Argentina
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
6.    Productos con categor�a 2, 4 o 6 y que NO est�n descontinuados
*/
select *
from Products
where CategoryID IN(2,4,6)
and Discontinued in (0)


 /*
7.    Clientes que NO son de Alemania, Reino Unido ni Canad�*/
select *
from Customers
where not Country IN ('Germany', 'UK', 'Canada')

/*
8.    Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canad� */
select *
from Orders
where ShipVia In (2,3)
and not ShipCountry In ('Canada','USA')

/*
9.    Empleados que trabajan en 'London' o 'Seattle' y fueron contratados despu�s de 1995*/

select *
from Employees
where City IN ('London', 'Seattle')
and year(HireDate) = 1995


/*
10.    Productos de categor�as 1, 3 o 5 con stock mayor a 50 y que NO est�n descontinuados
*/
select *
from Products
where CategoryID in (1,3,5)
and (UnitsInStock >= 50)
and Discontinued�in�(0)



