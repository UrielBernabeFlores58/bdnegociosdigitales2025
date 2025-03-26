# Transact Fechas,Cadenas,Instrucciones

## ejercicio 7 de la unidad 2

``` sql
-- Funciones de Cadena

/* las funciones de coadena permite manipular tiposd de datos
como varchar, nvarchar,char,nchar 

funcion Len -> la funcion len devuelve la longitud de una cadena

DECLARACION DE VARIABLE 

TEXTO VARCHAR 50

*/
DECLARE @Texto varchar(50) = 'Hola,Mundo!'

DECLARE @Numero int;
SET @Numero = 10;


-- obtener el tamanio de ka cadena almacenada en la variable texto
go 
DECLARE @Texto varchar(50) = 'Hola,Mundo!';

select LEN (@Texto) as [Longitud]

go



select CompanyName, len(CompanyName) from Customers

/*
-- Funcion LEF
extrae un numerop especifico de caracteres desde el inicio de la 
cadena */

DECLARE @Texto varchar(50) = 'Hola,Mundo!';
select LEFT(@Texto,4) as Inicio
 go
 /* rigth
 extare un determinado numero de caracteres del final de la cadena */

 
DECLARE @Texto varchar(50) = 'Hola,Mundo!';
select RIGHT(@Texto,6) as Final
go 

select CompanyName, len(CompanyName) as 'Numero de caracteres',
left(CompanyName, 4) as Inicio,
right(CompanyName, 6) as Final,
substring(CompanyName,7,4) as 'Subcadena'
from Customers



-- substring -> extrae una parte de la cadena , donde el primer parametro es de donde inicia
-- y el segundo que vaa rrecorrer, (5, recorrera 5 caracteres contando el primer parametro)
DECLARE @Texto2 varchar(50) = 'Hola, Mundo!';
select SUBSTRING(@Texto2,7,5)


-- replace -> remplaza una subcadena por otra 
DECLARE @Texto3 varchar(50) = 'Hola, Mundo!';
select REPLACE(@Texto3,'Mundo!','Amigo')
go 

-- charindex
DECLARE @Texto3 varchar(50) = 'Hola, Mundo!';
select CHARINDEX ('Mundo',@Texto3)
go

--upper convierte una cadena en mayusculas
DECLARE @Texto3 varchar(50) = 'Hola, Mundo!';
select concat (left(@Texto3, 6),

upper (substring ( @Texto3, 7, 5)),

RIGHT(@Texto3,1)) as Mayuscula


select upper (CompanyName) from Customers


-- UPDATE
Update Customers 
set /*campo que voy a cambiar */ CompanyName  = UPPER (CompanyName)
where Country in ('Mexico', 'Germany') 

-- trim quita espacion en blanco de una cadena 
DECLARE @Texto4 varchar(50) = '  Hola, Mundo!';
SELECT TRIM( @Texto4) AS Result;
go




```