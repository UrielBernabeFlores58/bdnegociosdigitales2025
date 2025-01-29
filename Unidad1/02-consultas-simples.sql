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
where ReportsTo IS NULL;
