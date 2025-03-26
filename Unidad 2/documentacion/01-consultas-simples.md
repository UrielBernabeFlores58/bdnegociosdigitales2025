# Consultas Simples

## Ejercicio 1 de la Unidad 2

```sql
-- LENGUAJE SQL LMD
-- CONSULTAS SIMPLES 

USE Northwind;

/* Consultas:
   - Mostrar todos los clientes de la empresa con todas las columnas de datos.
   - Mostrar todos los clientes, proveedores, categorías, productos, órdenes, detalle de la orden y empleados.
*/

SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Orders;
SELECT * FROM Suppliers;
SELECT * FROM Products;
SELECT * FROM Shippers;
SELECT * FROM Categories;
SELECT * FROM [Order Details];

-- Proyección: Mostrar ID, nombre, precio unitario y unidades en stock de los productos.
SELECT ProductID, ProductName, UnitPrice, UnitsInStock FROM Products;

-- Seleccionar y mostrar número de empleado, primer nombre, cargo y ciudad.
SELECT EmployeeID, Country, City, FirstName, Title FROM Employees;

-- Uso de alias en columnas
SELECT EmployeeID AS 'Numero Empleado', 
       FirstName AS 'Primer Nombre', 
       Title AS 'Cargo', 
       City AS 'Ciudad', 
       Country AS 'País' 
FROM Employees;

/* Campos calculados: Seleccionar el importe de cada producto vendido en una orden */
SELECT *, (UnitPrice * Quantity) AS Importe FROM [Order Details];

-- Eliminar filas duplicadas usando DISTINCT
SELECT DISTINCT Country FROM Customers ORDER BY Country;

/* Seleccionar fechas en orden (Año, Mes, Día), cliente y empleado que realizó la orden */
SELECT OrderDate, 
       YEAR(OrderDate) AS Año, 
       MONTH(OrderDate) AS Mes, 
       DAY(OrderDate) AS Día, 
       CustomerID, 
       EmployeeID 
FROM Orders;

/* Clausula WHERE con operadores relacionales (<, >, =, <=, >=, !=, <>) */

-- Seleccionar el cliente 'BOLID'
SELECT CustomerID, CompanyName, City, Country FROM Customers WHERE CustomerID = 'BOLID';

-- Seleccionar clientes de Alemania
SELECT CustomerID AS Identificador, 
       CompanyName AS NombreEmpresa, 
       ContactName AS Contacto, 
       Country AS País 
FROM Customers 
WHERE Country = 'Germany';

-- Seleccionar clientes que NO sean de Alemania (dos formas)
SELECT CustomerID, CompanyName, ContactName, Country FROM Customers WHERE Country != 'Germany';
SELECT CustomerID, CompanyName, ContactName, Country FROM Customers WHERE Country <> 'Germany';

/* Seleccionar productos donde el precio sea mayor a 100 */
SELECT ProductName, CategoryID, UnitsInStock, UnitPrice, (UnitPrice * UnitsInStock) AS Importe 
FROM Products 
WHERE UnitPrice > 100;

/* Seleccionar órdenes de compra del año 1996 */
SELECT OrderDate AS FechaOrden, 
       RequiredDate AS FechaEntrega, 
       ShippedDate AS FechaEnvio, 
       ShipName AS Cliente 
FROM Orders 
WHERE YEAR(OrderDate) = 1996;

/* Mostrar órdenes donde la cantidad comprada sea mayor a 40 */
SELECT * FROM [Order Details] WHERE Quantity > 40;

/* Mostrar empleados con datos relevantes */
SELECT EmployeeID AS Numero, 
       FirstName AS Nombre, 
       LastName AS Apellido, 
       BirthDate AS Nacimiento, 
       City AS Ciudad, 
       HireDate AS Contratacion 
FROM Employees 
WHERE YEAR(HireDate) > 1993;

-- Formas de concatenar nombres

-- Forma 1: Concatenación simple
SELECT EmployeeID AS Numero, (FirstName + ' ' + LastName) AS NombreCompleto, 
       BirthDate AS Nacimiento, City AS Ciudad, HireDate AS Contratacion 
FROM Employees 
WHERE YEAR(HireDate) > 1993;

-- Forma 2: Uso de CONCAT
SELECT EmployeeID AS Numero, CONCAT(FirstName, ' ', LastName) AS [Nombre Completo], 
       BirthDate AS Nacimiento, City AS Ciudad, HireDate AS Contratacion 
FROM Employees 
WHERE YEAR(HireDate) > 1993;

-- Mostrar empleados que no son dirigidos por el jefe número 2
SELECT FirstName AS Nombre FROM Employees WHERE ReportsTo <> 2;

-- Seleccionar empleados que no tienen jefe
SELECT * FROM Employees WHERE ReportsTo IS NULL;
