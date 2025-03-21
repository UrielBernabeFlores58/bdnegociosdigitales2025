# MongoDB CRUD

## Crear una base de datos  

*Solo se crea si contiene por lo menos una coleccion*


`json

use basede

`

## Crear una collecion

`use db1
db.createCollection ('Empleado')`

## Mostrar colecciiones
`show collections`

## Insercion de un documento
`db.Empleado.insertOne(
    {
    nombre: 'Soyla',
    apellido: 'Vaca',
    edad: 32,
    ciudad: 'San Miguel de las Piedras'
    }
)`