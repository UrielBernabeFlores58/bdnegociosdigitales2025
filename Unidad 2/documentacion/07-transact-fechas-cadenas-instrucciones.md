# Transact Fechas, Cadenas, Instrucciones

## ejercicio 7 de la unidad 2

```sql
-- Funciones de Cadena

/* Las funciones de cadena permiten manipular tipos de datos
como varchar, nvarchar, char, nchar 

Función Len -> La función len devuelve la longitud de una cadena

Declaración de variable 

TEXTO VARCHAR 50
*/
DECLARE @Texto varchar(50) = 'Hola,Mundo!';

DECLARE @Numero int;
SET @Numero = 10;

-- Obtener el tamaño de la cadena almacenada en la variable texto
GO 
DECLARE @Texto varchar(50) = 'Hola,Mundo!';

SELECT LEN(@Texto) AS [Longitud];

GO

SELECT CompanyName, LEN(CompanyName) FROM Customers;

/*
-- Función LEFT
Extrae un número específico de caracteres desde el inicio de la 
cadena 
*/
DECLARE @Texto varchar(50) = 'Hola,Mundo!';
SELECT LEFT(@Texto, 4) AS Inicio;
GO

/* RIGHT
Extrae un determinado número de caracteres del final de la cadena */
DECLARE @Texto varchar(50) = 'Hola,Mundo!';
SELECT RIGHT(@Texto, 6) AS Final;
GO 

SELECT CompanyName, 
       LEN(CompanyName) AS 'Numero de caracteres',
       LEFT(CompanyName, 4) AS Inicio,
       RIGHT(CompanyName, 6) AS Final,
       SUBSTRING(CompanyName, 7, 4) AS 'Subcadena'
FROM Customers;

/* 
SUBSTRING -> Extrae una parte de la cadena, donde el primer parámetro es de donde inicia
y el segundo que va a recorrer, (5, recorrerá 5 caracteres contando el primer parámetro)
*/
DECLARE @Texto2 varchar(50) = 'Hola, Mundo!';
SELECT SUBSTRING(@Texto2, 7, 5);

-- REPLACE -> Reemplaza una subcadena por otra 
DECLARE @Texto3 varchar(50) = 'Hola, Mundo!';
SELECT REPLACE(@Texto3, 'Mundo!', 'Amigo');
GO 

-- CHARINDEX
DECLARE @Texto3 varchar(50) = 'Hola, Mundo!';
SELECT CHARINDEX('Mundo', @Texto3);
GO

-- UPPER convierte una cadena en mayúsculas
DECLARE @Texto3 varchar(50) = 'Hola, Mundo!';
SELECT CONCAT(LEFT(@Texto3, 6),
              UPPER(SUBSTRING(@Texto3, 7, 5)),
              RIGHT(@Texto3, 1)) AS Mayuscula;

SELECT UPPER(CompanyName) FROM Customers;

-- UPDATE
UPDATE Customers 
SET /* Campo que voy a cambiar */ 
    CompanyName = UPPER(CompanyName)
WHERE Country IN ('Mexico', 'Germany'); 

-- TRIM quita espacio en blanco de una cadena 
DECLARE @Texto4 varchar(50) = '  Hola, Mundo!';
SELECT TRIM(@Texto4) AS Result;
GO
