# Left Join

## Ejercicio 4 de la Unidad 2

```sql
-- EJEMPLO DE LEFT JOIN APLICADO

SELECT * FROM products_new;

/* carga full */

INSERT INTO products_new
SELECT
    p.ProductID, 
    p.ProductName,
    cu.CompanyName,  
    c.CategoryName, 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS 'insert_date'
FROM Products AS p
JOIN Categories AS c ON p.CategoryID = c.CategoryID
JOIN [Order Details] AS od ON od.ProductID = p.ProductID
JOIN Orders AS o ON o.OrderID = od.OrderID
JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

-- crear una tabla a partir de una consulta 

SELECT
    p.ProductID, 
    p.ProductName,
    cu.CompanyName,  
    c.CategoryName, 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS 'inserted_date'
INTO products_new
FROM Products AS p
JOIN Categories AS c ON p.CategoryID = c.CategoryID
JOIN [Order Details] AS od ON od.ProductID = p.ProductID
JOIN Orders AS o ON o.OrderID = od.OrderID
JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

-- sin registro

SELECT
    TOP 0 
    p.ProductID, 
    p.ProductName,
    cu.CompanyName,  
    c.CategoryName, 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS 'inserted_date'
INTO products_new
FROM Products AS p
JOIN Categories AS c ON p.CategoryID = c.CategoryID
JOIN [Order Details] AS od ON od.ProductID = p.ProductID
JOIN Orders AS o ON o.OrderID = od.OrderID
JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

-- cambio de nombre de columnas

SELECT
    TOP 0 
    0 AS [productbk], 
    p.ProductID, 
    p.ProductName AS 'Producto',
    cu.CompanyName AS 'Customer',  
    c.CategoryName AS 'Category', 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS 'inserted_date'
INTO products_new
FROM Products AS p
JOIN Categories AS c ON p.CategoryID = c.CategoryID
JOIN [Order Details] AS od ON od.ProductID = p.ProductID
JOIN Orders AS o ON o.OrderID = od.OrderID
JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

ALTER TABLE products_new
ADD CONSTRAINT pk_products_new PRIMARY KEY (productbk);

/* Carga Full */
SELECT 
    TOP 0 
    p.ProductID, 
    p.ProductName AS 'Producto',
    cu.CompanyName AS 'Customer',  
    c.CategoryName AS 'Category', 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS 'inserted_date'
INTO products_new
FROM Products AS p
JOIN Categories AS c ON p.CategoryID = c.CategoryID
JOIN [Order Details] AS od ON od.ProductID = p.ProductID
JOIN Orders AS o ON o.OrderID = od.OrderID
JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

-- Eliminar tabla si existe
DROP TABLE products_new;

-- Crear nueva tabla
ALTER TABLE products_new 
ADD productbk INT NOT NULL IDENTITY (1,1);

-- Asignar clave primaria
ALTER TABLE products_new
ADD CONSTRAINT pk_products_new PRIMARY KEY (productbk);

/* Insertar datos en la nueva tabla */
INSERT INTO products_new (ProductID, Producto, Customer, Category, UnitPrice, Discontinued, inserted_date)
SELECT
    p.ProductID, 
    p.ProductName,
    cu.CompanyName,  
    c.CategoryName, 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS 'insert_date'
FROM Products AS p
JOIN Categories AS c ON p.CategoryID = c.CategoryID
JOIN [Order Details] AS od ON od.ProductID = p.ProductID
JOIN Orders AS o ON o.OrderID = od.OrderID
JOIN Customers AS cu ON cu.CustomerID = o.CustomerID;

-- INNER JOIN
-- LEFT JOIN
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
FROM Products AS p
JOIN products_new AS pn ON p.ProductID = pn.ProductID
WHERE pn.ProductID IS NULL;

-- LEFT JOIN
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
FROM Products AS p
LEFT JOIN products_new AS pn ON p.ProductID = pn.ProductID
WHERE pn.ProductID IS NULL;

/* Carga delta */
INSERT INTO products_new (ProductID, Producto, Customer, Category, UnitPrice, Discontinued, inserted_date)
SELECT 
    p.ProductID, 
    p.ProductName,
    [cu].CompanyName, 
    c.CategoryName, 
    od.UnitPrice, 
    p.Discontinued, 
    GETDATE() AS 'inserted_date'
FROM Products AS p 
LEFT JOIN Categories AS c ON p.CategoryID = c.CategoryID
LEFT JOIN [Order Details] AS od ON od.ProductID = p.ProductID
LEFT JOIN Orders AS o ON o.OrderID = od.OrderID
LEFT JOIN Customers AS [cu] ON [cu].CustomerID = o.CustomerID
LEFT JOIN products_new AS pn ON pn.ProductID = p.ProductID
WHERE pn.ProductID IS NULL;
