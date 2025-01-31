-- LENGUAJE SQL LMD
-- CONSULTAS SIMPLES 

use Northwind;

/* consultas
mostrarall clientes de la empresa con todas las columnas de datos de la empresa(SELECT, UPDATE,DELETE, CRUD, INSERT)
mostrar todos los clientes, proveedores,categorias,productos,ordenes, detalle de la orden, empleados
*/


select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details]

-- Proyeccion
select ProductID, ProductName,UnitPrice, UnitsInStock  
from Products;

-- seleccionar, mostrar el numero de empleado,primer nombre, cargo, ciudad

select EmployeeID, Country, City, FirstName, Title  from Employees


-- alias columna, en base  ala consukta ant, visualizar el empleado id como numero de empleado, first name como primer nombre
-- title como cargo, city como ciudad, country como pais


select EmployeeID as 'Numero Empleado' /*[Numero Empleado]*/,FirstName as primernombre, 
Title as cargo, City as ciudad, Country as pais from Employees;


/* campos calculados, 
seleccionar el importe de cada uno de los productos vendidos, en una orden*/


select *,(UnitPrice*Quantity) as importe from [Order Details];


-- filas duplicadas,	Distinct

 select * from Customers;
 
 select distinct Country from Customers
 order by Country;


/* seleccionar las fechas en orden, año, mes , dia, el cliente que las ordeno
y el empleado que la realizo*/

select OrderDate,year(OrderDate) as Año, month(OrderDate) as Mes, DAY(OrderDate) as Dia,CustomerID, EmployeeID from Orders;

/* clausula where 
operadores relacionales (<,>,=,<=,>=, != o <>)


seleccionar el cliente BOLID
id,name, country
*/

select CustomerID,CompanyName, City, Country from Customers
where CustomerID = 'BOLID';


/* SELECCIONAR CLIENTES, MOSTRANDO IDENTIFICADOR, NOMBRE DE LA EMPRESA, CONTACTO, CUIDAD, Y PAIS DE ALEMANIA */

select * from Customers;


select CustomerID as Identificador ,CompanyName as NombreEmpresa,
ContactName as Contacto , Country as Ciudad from Customers
where Country != 'Germany';


/* 
-----------------------------------------------------
para que no sean de un pais (operador)
select CustomerID as Identificador ,CompanyName as NombreEmpresa,
ContactName as Contacto , Country as Ciudad from Customers
where Country != 'Germany';
-----------------------------------------------------------------
con (<>)
select CustomerID as Identificador ,CompanyName as NombreEmpresa,
ContactName as Contacto , Country as Ciudad from Customers
where Country <> 'Germany';
---------------------------------------------------------------------

seleccionar todos los productos mostrando su nombre de producto, categoria a la que pertenece
existencia, precio, donde el precio sea mayor a 100 
*/

select * from Products;


select ProductName, CategoryID, UnitsInStock, UnitPrice, (UnitPrice * UnitsInStock) as Import from Products
where UnitPrice > 100
;

/* seleccionar las ordenes de compra, mostrando la fecha de orden, la de requerimiento, fecha de envio, el cliente, 
de 1996*/


select OrderDate as FechaOrden, 
RequiredDate as FechaEntrega,
ShippedDate as FechaEnvio, 
ShipName as Cliente from Orders
where OrderDate = 1996
;


/* mostar todas las ordenes de compra donde la cantidad de productos comprados
sea mayor a 5 */


select Quantity from [Order Details]

where Quantity > 40;

select* from Employees;

select EmployeeID as Numero , FirstName as Nombre, LastName as Apellido,
BirthDate as Nacimiento, City as Ciudad,
HireDate as Contratacion
from Employees
where year(HireDate) > 1993;

------------------------------ forma 2 forma de concatenar 2 campos en este caso nombre completo

select EmployeeID as Numero , (FirstName+''+  LastName) as NombreCompleto,
BirthDate as Nacimiento, City as Ciudad,
HireDate as Contratacion
from Employees
where year(HireDate) > 1993;

-------------------------------------- forma 3 concat 

select EmployeeID as Numero , concat (FirstName, ' ' ,LastName) as [Nombre Completo],
BirthDate as Nacimiento, City as Ciudad,
HireDate as Contratacion
from Employees
where year(HireDate) > 1993;


------------------------------------------- mostrar los empleados que no son dirigidos por el
/* empleado por el jefe 2 */ 

select FirstName as Nombre from Employees
where ReportsTo <> 2;
/*
seleccionar empleados que no tengan jefe */

select * from Employees
where ReportsTo is null;


-- consultas logicas (operadores logicos) , or, and, not   ---30/01/2025---
--  SELECCIONAR PRODUCTOS QUE TENGAN PRECIO ENTRE 10 Y 50

select ProductName, UnitPrice, UnitsInStock from Products 
where UnitPrice >= 10 and UnitPrice <=50
;

-- mostrar todos los pedidos realizadps por los clientes que no son enviados a alemania
select * from  Orders
where ShipCountry <> 'Germany';

-------------------------------------

select * from  Orders
where not  ShipCountry = 'Germany';

-- mostrar clientes de mexico o usa
select * from  Customers
where Country = 'Mexico' or Country = 'USA'
;

-- empleados que nacieron entre 1955 y 1958
select * from Employees
where  year(BirthDate)  >=  1955 and year(BirthDate) <=1958
and City = 'London';

-- seleccionar pedidos con fletes mayor a 100 y enviados a francia O españa

select OrderID, year (OrderDate) as OrderDate, ShipCountry, Freight from  Orders
where Freight > 100 and (ShipCountry = 'Spain' or ShipCountry = 'France') ;



--SELECCIONAR LAS PRIMERAS 5 PRDENES DE COMPRA (TOP PARA LIMITE)

select top 5 * from Orders;

/* Seleccionar Productos con precio entre 10 y 50, que NO esten descontinuados y tengan mas de 20 unidades
*/

select ProductName, UnitPrice, UnitsInStock, Discontinued 
from Products
where UnitPrice >= 10 and UnitPrice<= 50 
and Discontinued = 0
and UnitsInStock> 20;
------------------


select OrderID, ShipCountry, Freight from  Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany')
and Freight <50
;

-- clientes que no sean d emexico o usa y que tengan un fax registrado
select CompanyName, Country, City, Fax from Customers
where not (Country ='USA' or Country = 'Mexico') and Fax is not null
;

--  seleccionar pedidos con un flete mayor a 100, enciados a brazil o argentina
-- pero no enviados transportista 1'

select * from Shippers;
select * from Orders
where Freight > 100 and (ShipCountry = 'Brazil' or ShipCountry = 'Argentina')
and ShipVia <> 1
;

select * from Orders
where Freight > 100 and (ShipCountry = 'Brazil' or ShipCountry = 'Argentina')
and not ShipVia = 1
;
-- 1
select concat(FirstName , ' ' , LastName) as [Nombre Completo],
HireDate,City, Country
from Employees
where not (City = 'London' or City = 'Seattle')
and YEAR(HireDate)  >= 1992

-- 2 (AND Y <>)

select concat(FirstName , ' ' , LastName) as [Nombre Completo],
HireDate,City, Country
from Employees
where (City <> 'London' and City <> 'Seattle')
and YEAR(HireDate)  >= 1992


/* Clausula IN (or)
seleccionar productos con categortia 1, 3 o 5 */

select ProductName, CategoryID, UnitPrice from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5 
;


select ProductName, CategoryID, UnitPrice from Products
where CategoryID in (1,3,5)
;

-- seleccionar todas las ordenes de la region RJ, Tachira que no tengan region ASIGNADA
-- select * from Orders

select OrderID, year(OrderDate) as Año, ShipRegion from Orders
where ShipRegion in ('RJ', 'Táchira') or ShipRegion is null;
/*
seleccionar ordenes que tengan cantidades de 12,9 o 40 y descuento de 
0.15 0 0.05
*/
-- 1
 select * from [Order Details]
 where Quantity in (12, 9, 40) and 
 (Discount = 0.15 or Discount = 0.05);
 ----- 2 
 select OrderID, Quantity, Discount from [Order Details]
 where Quantity in (12, 9, 40) and 
 (Discount = 0.15 or Discount = 0.05);
 ----- 3
 select OrderID, Quantity, Discount from [Order Details]
 where Quantity in (12, 9, 40) and 
 Discount in (0.15, 0.05);


-- Clausula Between (siempre va en el where)

select * from Products
where UnitPrice between 10 and 50;


-- seleccionar todos los pedidos entre el primero de enero y 30 de junio


select * from Orders
where OrderDate >= '1997-01-01' AND OrderDate <= '1997-06-30';


select * from Orders
where OrderDate between '1997-01-01' and '1997-06-30' ;


-- seleccionar todos los empleados contratados entre 1990 y 1995 que trabajan en lontdres

select * from Employees
where year(HireDate) between '1992' and '1994'
and City = 'London'
;

-- PEDIDOS CON FREIGTH ENTRE 50 Y 200 ENVIADOS A ALEMANIA Y A FRANCIA

select OrderID,ShipCity, Freight,ShipCountry from Orders
where Freight between 50 and 200 and 
(ShipCountry = 'Germany' or ShipCountry = 'France')
;


-- seleciionar todos los productos que tengan un precio entre 5 y 20 dls o que sean de la categoria 1,2,3
-- seleccionar 


select ProductName, CategoryID, UnitPrice from Products
where UnitPrice between 5 and 20 and
CategoryID in (1,2,3)
;

-- EMPLEADOS CON NUMEROS DE TRABAJADOR EMTRE 3 Y 7 QUE NO TRABAJAN EN LONDRES NI SEATTLE

select EmployeeID as 'Numero de empleado', concat (FirstName, LastName) as 'Nombre Completo', City as 'Ciudad' from Employees
where EmployeeID between 3 and 7
and not City in ('London', 'Seattle')
;

-- clausula like
/*
		patrones
		1) "%" representa cero o mas caracteres en el patron de busqueda 
		2) "_" representa exactamente un caracter en el patron de busqueda
		3) "[]"  se utliza para definir un conjunto de caracteres buscando cualquiera de ellos 
		en la posicion especifica
		4) "[^ ]"  se utiliza para buscar cacateres que no estan dentro del conjunto especifico

buscar los productos que comienzan con cha
*/
-- c
select * from Products
where ProductName Like 'C%'

select * from Products
where ProductName Like 'Cha%'


select * from Products
where ProductName Like 'Cha%'
and UnitPrice=18;


select * from Products
where ProductName Like '%e'
;

select * from Customers
where CompanyName like '%co%'
;


-- buscar empleados cuyo nombre comience con a y que tenga 5 caracteres

select FirstName, LastName from Employees
where FirstName like 'a_____'
