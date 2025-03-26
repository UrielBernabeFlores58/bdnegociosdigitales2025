# Consultas de Agregados

## Ejercicio 2 de la Unidad 2

```sql
/* Consultas de agregado
   - Solo devuelven un solo registro.
   - Funciones: SUM, AVG, COUNT, MIN, MAX.
*/

-- ¿Cuántos clientes hay?
SELECT COUNT(*) AS [Numero de Clientes] FROM Customers;

-- ¿Cuántas regiones hay?
SELECT COUNT(Region) AS [Regiones] FROM Customers;

-- Versión 2 (Regiones únicas y no nulas)
SELECT COUNT(DISTINCT Region) AS [Regiones] FROM Customers WHERE Region IS NOT NULL;

-- Contar órdenes y regiones de envío
SELECT COUNT(*) FROM Orders;
SELECT COUNT(ShipRegion) FROM Orders; -- COUNT no cuenta valores NULL.

/* Seleccionar el precio mínimo, máximo y el promedio de unidades en stock */
SELECT MIN(UnitPrice) AS PrecioMinimo, 
       MAX(UnitPrice) AS PrecioMaximo, 
       AVG(UnitsInStock) AS PromedioStock 
FROM Products;

-- ¿Cuántos pedidos existen?
SELECT COUNT(OrderID) FROM Orders;

-- Calcular el total de dinero vendido
SELECT SUM(UnitPrice * Quantity) AS TotalVentas FROM [Order Details];
SELECT SUM(UnitPrice * Quantity - (UnitPrice * Quantity * Discount)) AS TotalConDescuento FROM [Order Details];

-- Calcular el total de unidades en stock de todos los productos
SELECT SUM(UnitsInStock) AS [Total de Unidades] FROM Products;

/* Uso de GROUP BY */

-- Seleccionar el número de productos por categoría
SELECT CategoryID, COUNT(*) AS [Numero de Productos] FROM Products GROUP BY CategoryID;

-- Seleccionar el número de productos por categoría con JOIN
SELECT Categories.CategoryName, COUNT(*) AS [Numero de Productos] 
FROM Categories 
INNER JOIN Products AS p ON Categories.CategoryID = p.CategoryID 
GROUP BY Categories.CategoryName;

-- Calcular el precio promedio de los productos por categoría
SELECT CategoryID, AVG(UnitPrice) AS [Precio Promedio] FROM Products GROUP BY CategoryID;

-- Seleccionar el número de pedidos realizados por cada empleado
SELECT EmployeeID, COUNT(*) AS [Numero de Pedidos] FROM Orders GROUP BY EmployeeID;

-- Seleccionar el número de pedidos realizados por cada empleado en el último trimestre de 1996
SELECT EmployeeID, COUNT(*) AS [Pedidos Realizados] 
FROM Orders
WHERE OrderDate BETWEEN '1996-10-01' AND '1996-12-31'
GROUP BY EmployeeID;

-- Seleccionar la suma total de unidades vendidas por cada producto
SELECT OrderID, ProductID, SUM(Quantity) AS [Unidades Vendidas] 
FROM [Order Details] 
GROUP BY OrderID, ProductID
ORDER BY 2 DESC;

/* Seleccionar el número de productos por categoría,
   pero solo aquellos que tengan más de 10 productos. */

-- Paso 1: Visualizar los productos
SELECT * FROM Products;

-- Paso 2: Filtrar categorías específicas
SELECT CategoryID FROM Products WHERE CategoryID IN (2,4,8) ORDER BY CategoryID ASC;

-- Paso 3: Contar productos en cada categoría y filtrar los que tienen más de 10
SELECT CategoryID, SUM(UnitsInStock) AS TotalStock 
FROM Products 
WHERE CategoryID IN (2,4,8)
GROUP BY CategoryID
HAVING COUNT(*) > 10
ORDER BY CategoryID ASC;

/* Listar las órdenes agrupadas por empleado,
   pero solo mostrar aquellos que hayan gestionado más de 10 pedidos. */

SELECT * FROM Orders;

SELECT EmployeeID, COUNT(*) AS [Pedidos Gestionados] 
FROM Orders
GROUP BY EmployeeID
HAVING COUNT(*) > 10;
```
