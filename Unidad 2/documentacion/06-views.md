# Vistas

## Ejercicio 6 de la Unidad 2
```sql
-- Views 

-- sintaxis 
/* create view nombreVista 
AS
select columnas
from tabla 
where condicion
*/

USE northwind;
GO

CREATE OR ALTER VIEW VistaCategoriasTodas
AS
SELECT CategoryID, CategoryName, [Description], picture 
FROM Categories
WHERE CategoryName = 'Beverages';

GO

DROP VIEW VistaCategoriasTodas;
GO

SELECT * FROM VistaCategoriasTodas
WHERE CategoryName = 'Beverages';

-- Crear una vista que permita visualizar solamente clientes de mexico y brazil
GO

CREATE OR ALTER VIEW vistaClientesLatinos
AS
SELECT * FROM Customers
WHERE country IN('MExico','Brazil');

SELECT CompanyName AS [Cliente], 
       City AS [Ciudad], 
       country AS [Pais]
FROM vistaClientesLatinos
WHERE city = 'Sao Paulo'
ORDER BY 2 DESC;

SELECT * FROM 
Orders AS o 
INNER JOIN vistaClientesLatinos AS vcl
ON vcl.CustomerID = o.CustomerID;

-- Crear una vista que contenga los datos de todas las ordenes
-- los productos, categorias de productos, empleados y clientes,  
-- en la orden 
-- calcular el importe 

CREATE OR ALTER VIEW [dbo].[vistaordenescompra]
AS
SELECT o.OrderID AS [numero Orden], 
       o.OrderDate AS [Fecha de Orden], 
       o.RequiredDate AS [Fecha de Requisici�n],
       CONCAT(e.FirstName, ' ', e.LastName) AS [Nombre Empleado],
       cu.CompanyName AS [Nombre del Cliente], 
       p.ProductName AS [Nombre Producto], 
       c.CategoryName AS [Nombre de la Categoria], 
       od.UnitPrice AS [Precio de Venta],
       od.Quantity AS [Cantidad Vendida], 
       (od.Quantity * od.UnitPrice) AS [importe]
FROM  
Categories AS c
INNER JOIN Products AS p ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] AS od ON od.ProductID = p.ProductID
INNER JOIN Orders AS o ON od.OrderID = o.OrderID
INNER JOIN Customers AS cu ON cu.CustomerID = o.CustomerID
INNER JOIN Employees AS e ON e.EmployeeID = o.EmployeeID;

SELECT COUNT(DISTINCT [numero Orden]) AS [Numero de Ordenes]
FROM vistaordenescompra;

SELECT SUM([Cantidad Vendida] * [Precio de Venta]) AS [importe Total]
FROM vistaordenescompra; 
GO

SELECT SUM(importe) AS [importe Total]
FROM vistaordenescompra 
WHERE YEAR([Fecha de Orden]) BETWEEN '1995' AND '1996';  
GO

CREATE OR ALTER VIEW vista_ordenes_1995_1996
AS
SELECT [Nombre del Cliente] AS 'Nombre Cliente', 
       SUM(importe) AS [importe Total]
FROM vistaordenescompra 
WHERE YEAR([Fecha de Orden]) BETWEEN '1995' AND '1996'  
GROUP BY [Nombre del Cliente]
HAVING COUNT(*) > 2;

CREATE SCHEMA rh;

CREATE TABLE rh.tablarh (
  id INT PRIMARY KEY, 
  nombre NVARCHAR(50)
);

-- vista horizontal
CREATE OR ALTER VIEW rh.viewcategoriasproductos
AS
SELECT c.CategoryID, CategoryName, p.ProductID, p.ProductName 
FROM 
Categories AS c
INNER JOIN Products AS p ON c.CategoryID = p.CategoryID;
GO

SELECT * FROM rh.viewcategoriasproductos;
