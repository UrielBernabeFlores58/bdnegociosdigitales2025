# MongoDB CRUD

## Crear una base de datos  

#### *Solo se crea si contiene por lo menos una coleccion*


`json

use db1

`

## Crear una collecion

`use db1
db.createCollection ('Empleado')`

## Mostrar colecciiones
`show collections`

## Insercion de un documento
`
db.Empleado.insertOne(
    {
    nombre: 'Soyla',
    apellido: 'Vaca',
    edad: 32,
    ciudad: 'San Miguel de las Piedras'
    }
)`


# Insercion de un documento con complejo de Array

``` json
db.Empleado.insertOne(

    {
    nombre: 'Ivan',
    apellido: 'Baltazar',
    apellido2: 'Rodriguez',
    aficiones: ['Cerveza', 'Canabis', 'Crico', 'Mentir'] 

    }
)
```

**Eliminar una coleccion**
```json
db.collection.drop()
```
_Ejemplo_
```json
db.Empleado.drop()
```

## Insercion de documentos mas complejos con documentos anidados, arrays y id's
```json
        db.alumnos.insertOne(
        {
            nombre: 'Jose Luis',
            apellido1: 'Herrera',
            apellido2: 'Gallardo',
            edad: 41,
            estudios: [
                'Ingenieria en Sistemas Computacionales',
                'Maestria en Administracion de Tecnologias de la Informacion'
            ],
            experiencia: {
                lenguaje: 'SQL',
                sgb: 'SqlServer',
                anios_experiencia: 20
            }
        }
        
        )

```

## Generar un ID personalizado

```json
    db.alumnos.insertOne({
        _id:3,
        nombre:'Sergio',
        apellido: 'Ramos',
        equipo: 'Monterrey',
        aficiones: ['Dinero','Hombres', 'Fiesta'],
        talentos:{
        futbol:true,
        bañarse:false
        }

    })
```

## Insertar Multiples  Documentos
 ###### _"  LLAVES SIGNIFICAN DOCUMENTO"_
```json
    
    db.alumnos.insertMany(
    [
   
       {
        nombre: 'Osgualdo',
        apellido: 'Venado',
        edad: 20,
        descripcion: 'Es un quejumbroso'
        },
        {
            nombre: 'Maritza',
            apellido: 'Rechiken',
            edad: 19,
            habilidades: [
                'Ser Vivora', 'Ilusionar', 'Caguamear'
            ],
            direccion: {
                calle: 'Del infierno',
                numero: 666
            },
            esposos:[
                {
                    nombre: 'Joshua',
                    edad: 20,
                    pension: -34,
                    hijos:
                    ['Ivan', 'Jose']
                },
                {
                    nombre: 'Leo',
                    edad: 15,
                    pension: 70,
                    complaciente:true
                }
            ]
        }
    ]
    )
```

# Busquedas, Condiciones Simples de Igualdad Metodo Find


1. Seleccionar todos los documentos de la coleccion libros

```json
    db.libros.find({})
```
2. Seleccionar todos los documentos que sean de la editorial biblio
```json
    db.libros.find({editorial:'Biblio'})
```
3. Mostrar todos los documentos que el precio sea 25
```json
    db.libros.find({precio:25})
```
4. seleccionar todos los documentos donde el titulo sea 
"Json para todos"
```json
    db.libros.find({titulo: 'JSON para todos'})
```

### Operadores de comparacion
[Operaadores de Comparacion](https://www.mongodb.com/docs/manual/reference/operator/query/)

1-. Operadores Logicos
 ![Comparacion](../mongodb/imgu3/Operadores-Logicos.png)
2-. Operadores Relacionales
 ![Comparacion](../mongodb/imgu3/operadores-Relacionales.png)

1. mostrar todos los documentoas que sea mayor a 25
```json
    db.libros.find({precio:{$gt:25}})
```

2. Mostrar los documentos donde el precio sea 25

```json
    db.libros.find({precio:{$eq:25}})
    
    db.libros.find(precio:25)
```

3. mostrar los documentos cuya cantidad sea menor a 5
```json
    db.libros.find({cantidad:{$lt:5}})
```
4. Mostrar los documentos que pertenecen a la editoria biblio o planeta
```json
    db.libros.find({editorial: {$in: ['Biblio','Planeta']}})
```
5. mostrar todos los documentos de libros que muestren 20 o 25
```json
 db.libros.find({precio: {$in: [20,25]}})
 ```
 6. recuperar todos los documentos que no cuesten 20 o 25
```json
    db.libros.find({ precio: { $nin: [20, 25] } })

```

# **Instrucción Find One**

7. Recuperar solo una fila (Devuelve el primer elemento que cumpla la condicion, solo el primero)

```json
 db.libros.findOne({precio: {$in: [20,25]}})
 ```

## Operadores Logicos
[Operadores Logicos](https://www.mongodb.com/docs/manual/reference/operator/query-logical/)

- Dos posibles Opciones

1. La simple, mediante condiciones por comas
    
    db.libros.find({condicion1,condicion2,..}) -> con esto asume que es un AND.

    Usando un Operador AND
    { $and: [ { <expression1> }, { <expression2> } , ... , { <expressionN> } ] }

    db.libros.find{ $and: [ {Condicion1},{Condicion2}]}

    1. Mostrar todos aquellos libros que cuesten mas de 25 y cuya cantidad sea inferior a 25
```json
    db.libros.find(
        {
        precio:{$gt:25},
        cantidad:{$lt:15}
        }
    )
```

## forma 2
```json
    db.libros.find(
        {
            $and:
            [
                {precio:{$gt:25}},
                {cantidad:{$lt:15}}
            ]
     
        }
    )
```

### Operador Or
1. Mostar todos aquellos libros que cuesten mas de 25 dolares o cuya cantidad sea inferior a 15
```json
db.libros.find( {
     $or: [
         { precio: { $gt: 25 } },
          { cantidad: 15 } 
            ]
    }
 )
```
### Ejemplo con AND y OR combinados
1.Mostrar los libros de la editorial Biblio con precio mayor a 40 o libros de la Editorial Planeta con Precio Mayor a 30

```json
db.libros.find(
    {
    $and:[
        {$or: [{editorial:'Biblio'}, {precio: {$gt:40}}] },
        {$or: [{editorial:'Planeta'}, {precio: {$gt:30}}] }
         ]
    }
)


```

### Proyeeción (ver ciertas colunas)

**Sintaxis**


`db.collection.find(filtro, columnas)`

1.seleccionar todos los libros solo mostrando el titulo

```json
db.libros.find({}, {titulo:1})
```

```json
db.libros.find({}, {titulo:1, _id:0})
```
Ejemplo hecho en MongoCompass
```json

db.libros.find(
  {},
  { _id: 0, titulo: 1, editorial: 1, precio: 1 }
);
```

### Operador Exist (Este permite saber i un campo se encuentra o no en un documento)

[Operador Exist](https://www.mongodb.com/docs/manual/reference/operator/query/exists/)
```json
db.libros.find({ editorial: { $exists: true } })
```

```json
db.libros.insertOne(
{
    _id:10,
    titulo: 'Mongo en Negocios Digitales',
    editorial: 'Terra',
    precio: 125
}
)

```

Buscar todos los documentos que no tengan cantidad

```json
db.libros.find({ cantidad: { $exists: false } })
```


## Operador Type (Permite Solicitar a MongoDB si un campo corresponde a un tipo)


[Operador Type](https://www.mongodb.com/docs/manual/reference/operator/query/type/)

### Mostrar todos los documetnso donde el precio sea de tipo double o entero o cualquier tipo de dato
------------------------------------------------
```json
db.libros.find({
    precio:{$type:1}

})
```
--------------------------------------------

```json
db.libros.find({
    precio:{$type:16}

})
```


```json
db.libros.insertMany(
 [
    {
    _id:12,
    titulo:'IA',
    editorial:'Terra',
    precio:125,
    cantidad:20
 },
 {
    _id:13,
    titulo:'Python para todos',
    editorial:2001,
    precio:200,
    cantidad:30
 }
 ]
)
```


seleccionar todos los documentos de libros donde los valores de la editorial sean string

```json
db.libros.find({
    precio:{$type:2}

})
```

```json
db.libros.find({
    precio:{$type:16}

})
```
```json
db.libros.find({
    precio:{$type:"int"}

})
```

# MODIFICANDO DOCUMENTOS

- UpdateOne --> Modifica un solo documento
- UpdateMany --> Modificar Multiples Documentos
- Replace One --> Sustituir el contenido completo de un documento

tiene el siguiente formato
```json
db.collection.UpdateOne(
{filtro},
{operator:}
)
```

[Operadores Update](https://www.mongodb.com/docs/manual/reference/operator/update/)

**Operador $Set**
1. Modificar un Documento

```json
    db.libros.updateOne({titulo: 'Python para todos' }, {$set:{titulo:'Java para todos'}})
```

Modificar el documento con id 10 estableciendo el precioen 100 y la cantidad en50
```json
     db.libros.updateOne(
     {
        _id:10
     },
     {
        $set:{precio:100, cantidad:50}
     }
     )
```
``
db.libros.find({})
``

Utilizando el updateMany, modificar todos los libros donde el precio sea mayor a 100 cambiarlo por 150

```json
    db.libros.updateMany
    (
    {
        precio:{$lt:100}
    },
    {
        $set:{precio:150}
    }   
    )
```
# Operadores $inc y $mul

Incrementar todos los precios de los libros en 5
```json
        db.libros.updateMany
    (
    {editorial: 'Terra'},
    {
        $inc:{precio:5}
    }   
    )

```
multiplicar por 2 todos los libros donde la cantidad sea mayor a 20

    ```json
    db.libros.updateMany
    (
    {
        _id:{$gt:2}
    },
    {
        $inc:{precio:-50}
    }   
    )
    ```

Actualizar todos los libros multiplicando la cantidad y el precio de todos aquellos libros donde el precio sea mayor a 20

```json
db.libros.updateMany
(
    {
        precio:{$gt:20}
    },
    {
        $mul:{cantidad:2, precio:2}
    }   
)
```


## Remplazar todo el documento (replaceOne)

Actualizar todo el documento del id 2 por el titulo de la tierra a la luna, autor julio verne editorial terra, precio 100

```json
db.libros.replaceOne
(
{
    _id:2
},
{
    titulo:'De la Tierra a la Luna',
    autor:'Julio Verne',
    editorial:'Terra',
    precio:100
}
)

```


##  Borrar Documentos

1. DeleteOne --> Elimina un solo documento
2. deleteMany --> Elimina Multiples Documentos

eliminar el documento con el id:2
```json
db.libros.deleteOne
(
    {_id:2}
)
```
borrar todos los libros donde la cantidad es mayor a 150

```json
db.libros.deleteMany
(
    precio:{$gt:150}
)

```
## Expresiones Regulares
selecccionar todos los libros que contengan en el titulo una t minuscula

```json
    db.libros.find({titulo:/t/ })
```

seleccionar todos los libros que en el titulo contenga la palabra JSON
```json
    db.libros.find({titulo:/JSON/ })
```
seleccionar todos los libros que en el titulo termine con tos
```json
    db.libros.find({titulo:/tos$/ })
```

seleccionar todos los libros que en el titulo comiencen con j
```json
    db.libros.find({titulo:/^J/ })
```
## Operador %regex 
[Operador %regex](https://www.mongodb.com/docs/manual/reference/operator/query/regex/)

## Seleccionar los libros que conbtengan la palabra "Para" en el titulo
```json
db.libros.find({titulo: {$regex: 'para'}})
```

Forma 2
```json
db.libros.find({titulo: {$regex:/para/}})

```
Seleccionar todos los titulos que tengan la palabra json
```json
db.libros.find({titulo: {$regex: 'JSON'}})
```
## distingir entre mayusculas y minusculas
 ```json
db.libros.find({titulo: {$regex:/json/i}})
```
Forma 2 de distinguir
```json
db.libros.find({titulo: {$regex:/json/, $options:'i'}})
```

Seleccionar todos los documentos donde el titulo comience con j y no distinga entre mayudculas y minusculas
```json
db.libros.find({titulo: {$regex:/^j/, $options:'i'}})
```
seleccionar todos los libros donde el titulo termine con  es y no distinga entre mayusculas y minusculas
```json
 db.libros.find({titulo: {$regex:/es$/} })
```

## Metodo sort (Ordenar Documentos)
-- ordenar los libros de manera asendente por el precio
```json
db.libros.find(
{}, {
    _id:0,
    titulo:1,
    precio:1
}).sort({precio:1})
```
-- ordenar los libros de manera desendente por el precio
```json
db.libros.find(
{}, {
    _id:0,
    titulo:1,
    precio:1
}).sort({precio:-1})
```
-- ordenar los libros de manera asendente por la editorial y de manera decendente por el precio mostrando el titulo, el precio y la editorial

```json
db.libros.find(
{}, {
    _id:0,
    titulo:1,
    precio:1,
    editorial:1
}).sort({precio:-1,editorial:1})
```

## Otros Metodos skip,limit, size(cuantos tengo)

```json
db.libros.find(
{}
).size()

db.libros.find({titulo: {$regex:/^j/ , $options: 'i' }}).size()
```
buscar todos los libros pero mostrando los primero 2

```json
db.libros.find({}).limit(2)
```

```json
db.libros.find({}).skip(2)
```



## Borrar Colecciones y base de datos
```json
db.libros.drop()
```
```json
db.dropDatabase()
```