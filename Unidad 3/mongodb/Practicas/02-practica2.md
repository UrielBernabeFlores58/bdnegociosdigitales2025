
---

# **Práctica 2: MongoDB**

## **Consultas**

---

### 1. **Cargar el archivo `empleados.json`**

```js
db.empleados.insertMany([
  {
    "nombre": "Gregory",
    "apellidos": "Juarez",
    "correo": "nisi.mauris.nulla@google.edu",
    "direccion": "2727 Nec, St.",
    "region": "Mizoram",
    "pais": "Norway",
    "empresa": "Google",
    "ventas": 26890,
    "salario": 3265,
    "departamentos": "Legal Department, Accounting, Media Relations, Research and Development"
  },
  {
    "nombre": "Candace",
    "apellidos": "Buck",
    "correo": "donec.dignissim@google.ca",
    "direccion": "Ap #559-7631 Donec Road",
    "region": "Møre og Romsdal",
    "pais": "India",
    "empresa": "Google",
    "ventas": 1023,
    "salario": 6657,
    "departamentos": "Asset Management, Sales and Marketing, Media Relations"
  },
  ...
  {
    "nombre": "Brady",
    "apellidos": "Castillo",
    "correo": "suscipit.nonummy.fusce@yahoo.com",
    "direccion": "1321 Suspendisse Ave",
    "region": "Magallanes y Antártica Chilena",
    "pais": "Italy",
    "empresa": "Google",
    "ventas": 14054,
    "salario": 5272,
    "departamentos": "Quality Assurance, Human Resources, Advertising, Sales and Marketing"
  }
])
```



---

### 2. **Usar la base de datos `cursos`**

```js
use cursos
```

---

### 3. **Buscar empleados que trabajen en Google**

```js
db.empleados.find({
  empresa: "Google"
})
```

---

### 4. **Empleados que vivan en Perú**

```js
db.empleados.find({
  pais: "Peru"
})
```

---

### 5. **Empleados que ganen más de $8000**

```js
db.empleados.find({
  salario: { $gt: 8000 }
})
```

---

### 6. **Empleados con salario menor a $8000**

```js
db.empleados.find({
  salario: { $lt: 8000 }
})
```

---

### 7. **Consulta anterior pero devolviendo una sola fila**

```js
db.empleados.findOne({
  salario: { $lt: 8000 }
})
```

---

### 8. **Empleados que trabajen en Google o Yahoo (uso de `$in`)**

```js
db.empleados.find({
  empresa: { $in: ["Google", "Yahoo"] }
})
```

---

### 9. **Empleados de Amazon que ganen más de $9000**

```js
db.empleados.find({
  empresa: "Amazon",
  salario: { $gt: 9000 }
})
```

---

### 10. **Empleados que trabajen en Google o Yahoo (uso de `$or`)**

```js
db.empleados.find({
  $or: [
    { empresa: "Google" },
    { empresa: "Yahoo" }
  ]
})
```

---

### 11. **Yahoo con salario > $6000 o Google con ventas < 20000**

```js
db.empleados.find({
  $or: [
    { empresa: "Yahoo", salario: { $gt: 6000 } },
    { empresa: "Google", ventas: { $lt: 20000 } }
  ]
})
```

---

### 12. **Mostrar nombre, apellidos y país de los empleados**

```js
db.empleados.find(
  {},
  {
    nombre: 1,
    apellidos: 1,
    pais: 1,
    _id: 0
  }
)
```

---
