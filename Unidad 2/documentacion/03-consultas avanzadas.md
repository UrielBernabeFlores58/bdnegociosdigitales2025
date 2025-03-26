# Consultas Avanzadas

## Ejercicio 3 de la Unidad 2

```sql
/* 07/02/2025
   JOINS: INNER, LEFT, RIGHT, CROSS
   ESTRUCTURA:
   SELECT * FROM TABLA_1
   INNER JOIN TABLA_2
   ON (PRIMARY KEY) = (FOREIGN KEY)
*/

USE Northwind;

-- Seleccionar las categorías avanzadas
SELECT * 
FROM Categories -- Izquierda
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID;

-- Consulta optimizada con campos específicos
SELECT Categories.CategoryID, CategoryName, ProductName, UnitsInStock, UnitPrice 
FROM Categories -- Izquierda
INNER JOIN Products
ON Categories.CategoryID = Products.CategoryID;

-- Uso de alias para mejorar la legibilidad
SELECT c.CategoryID AS [Número de Categoría], 
       c.CategoryName AS 'Nombre de Categoría',
       p.ProductName AS 'Nombre de Producto',
       p.UnitsInStock AS 'Unidades en Existencia',
       p.UnitPrice AS 'Precio'
FROM Categories AS c -- Izquierda
INNER JOIN Products AS p
ON c.CategoryID = p.CategoryID;

-- Seleccionar los productos de las categorías Beverages y Condiments donde la existencia esté entre 18 y 30
SELECT p.ProductName AS 'Producto',
       c.CategoryName AS 'Categoría',
       p.UnitsInStock AS 'Existencia'
FROM Categories AS c
INNER JOIN Products AS p
ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Beverages', 'Condiments')
AND p.UnitsInStock BETWEEN 18 AND 30
ORDER BY p.UnitsInStock ASC;

-- Seleccionar los productos y sus importes realizados de marzo a junio de 1996
SELECT o.OrderID, o.OrderDate, od.ProductID, 
       (od.UnitPrice * od.Quantity) AS [Importe]
FROM Orders AS o
JOIN [Order Details] AS od
ON od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1996-07-01' AND '1996-10-31';

-- Calcular el importe total de los pedidos en el rango de fechas
SELECT CONCAT('$', ' ', SUM(od.Quantity * od.UnitPrice)) AS 'Importe Total'
FROM Orders AS o
JOIN [Order Details] AS od
ON od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1996-07-01' AND '1996-10-31';

/* Consultas básicas con INNER JOIN */

-- Obtener los nombres de los clientes y los países a los que se enviaron sus pedidos
SELECT c.CompanyName AS 'Cliente',
       o.ShipCountry AS 'País de Envío'
FROM Customers AS c
INNER JOIN Orders AS o
ON c.CustomerID = o.CustomerID
ORDER BY o.ShipCountry DESC;

-- Obtener los productos y sus respectivos proveedores
SELECT p.ProductName AS 'Producto', 
       s.CompanyName AS 'Proveedor'
FROM Products AS p
JOIN Suppliers AS s
ON s.SupplierID = p.SupplierID;

-- Obtener los pedidos y los empleados que los gestionaron
SELECT o.OrderID AS 'Orden',
       CONCAT(e.FirstName, ' ', e.LastName) AS 'Empleado'
FROM Orders AS o
JOIN Employees AS e
ON e.EmployeeID = o.EmployeeID;

-- Listar los productos junto con sus precios y la categoría a la que pertenecen
SELECT p.ProductName, p.UnitPrice, c.CategoryID 
FROM Products AS p
JOIN Categories AS c
ON p.CategoryID = c.CategoryID;

-- Obtener el nombre del cliente, número de orden y la fecha de orden
SELECT c.ContactName, o.OrderID, o.OrderDate 
FROM Customers AS c
JOIN Orders AS o
ON c.CustomerID = o.CustomerID;

-- Listar las órdenes mostrando el número de orden, el nombre del producto y la cantidad vendida
SELECT od.OrderID, p.ProductName, od.Quantity AS 'Cantidad Vendida' 
FROM [Order Details] AS od
JOIN Products AS p
ON od.ProductID = p.ProductID;

-- Cantidad ordenada de mayor a menor
SELECT od.OrderID, p.ProductName, od.Quantity AS 'Cantidad Vendida' 
FROM [Order Details] AS od
JOIN Products AS p
ON od.ProductID = p.ProductID
ORDER BY od.Quantity DESC;

-- Obtener los 5 productos más vendidos
SELECT TOP 5 od.OrderID, p.ProductName, od.Quantity AS 'Cantidad Vendida' 
FROM [Order Details] AS od
JOIN Products AS p
ON od.ProductID = p.ProductID
ORDER BY od.Quantity DESC;

-- Obtener la cantidad total de productos vendidos por categoría
SELECT c.CategoryName AS 'Nombre de Categoría',  
       SUM(od.Quantity) AS 'Productos Vendidos'
FROM Categories AS c
JOIN Products AS p
ON c.CategoryID = p.CategoryID
JOIN [Order Details] AS od
ON od.ProductID = p.ProductID
GROUP BY c.CategoryName
ORDER BY c.CategoryName;

-- Obtener el total de ventas por empleado
SELECT CONCAT(e.FirstName, '-', e.LastName) AS 'Nombre',
       SUM((od.Quantity * od.UnitPrice) - (od.Quantity * od.UnitPrice) * od.Discount) AS 'Total Vendido'
FROM [Order Details] AS od
JOIN Orders AS o
ON od.OrderID = o.OrderID
JOIN Employees AS e
ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName;

-- Obtener los empleados y sus respectivos jefes
SELECT CONCAT(e1.FirstName, ' ', e1.LastName) AS 'Empleado',
       CONCAT(j1.FirstName, ' ', j1.LastName) AS 'Jefe'
FROM Employees AS e1
JOIN Employees AS j1
ON e1.ReportsTo = j1.EmployeeID;

-- Listar los pedidos y el nombre de la empresa de transporte utilizada
SELECT o.OrderID, s.CompanyName AS 'Empresa de Transporte'
FROM Shippers AS s
JOIN Orders AS o
ON o.ShipVia = s.ShipperID;

-- Obtener los clientes que han realizado pedidos con más de un producto
SELECT c.CompanyName, COUNT(DISTINCT od.ProductID) AS 'Número de Productos'
FROM Customers AS c
INNER JOIN Orders AS o
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] AS od
ON od.OrderID = o.OrderID
GROUP BY c.CompanyName
ORDER BY 2 DESC;

-- Listar los clientes ubicados en Alemania que realizaron pedidos antes del 1 de enero de 1997
SELECT c.CompanyName AS 'Cliente', o.OrderDate AS 'Pedido', c.Country 
FROM Customers AS c
JOIN Orders AS o
ON c.CustomerID = o.CustomerID
WHERE o.OrderDate < '1997-01-01' 
AND c.Country = 'Germany'
GROUP BY c.CompanyName, o.OrderDate, c.Country;
