
---

# **Práctica 1 de MongoDB**

## **Base de Datos, Colecciones e Inserts**

---

### **1. Conectarnos con `mongosh` a MongoDB**
```bash
mongosh
```

---

### **2. Crear una base de datos llamada `curso`**
```js
use curso
```

---

### **3. Comprobar que la base de datos no existe**
```js
show databases
```

---

### **4. Crear una colección llamada `facturas` y mostrarla**
```js
db.createCollection('facturas')
show collections
```

---

### **5. Insertar documentos en la colección `facturas`**
```js
db.facturas.insertMany([
  {
    Cod_Factura: 10,
    Cliente: "Frutas Ramirez",
    Total: 223
  },
  {
    Cod_Factura: 20,
    Cliente: "Ferreteria Juan",
    Total: 140
  }
])
```

---

### **6. Crear la colección `Producto` usando `insertOne`**
```js
db.Producto.insertOne({
  Cod_Producto: 1,
  Nombre: "Tornillo x 1\"",
  Precio: 2
})
```

---

### **7. Insertar un producto con array en la colección `Producto`**
```js
db.Producto.insertOne({
  Cod_Producto: 2,
  Nombre: "Martillo",
  Precio: 20,
  Unidades: 50,
  Fabricantes: ["fab1", "fab2", "fab3", "fab4"]
})
```

---

### **8. Borrar la colección `facturas` y comprobar**
```js
db.facturas.drop()
show collections
```

---

### **9. Insertar documento en colección `fabricantes` con subdocumento y _id personalizado**
```js
db.fabricantes.insertOne({
  _id: 1,
  Nombre: "fab1",
  Localidad: {
    ciudad: "buenos aires",
    pais: "argentina",
    Calle: "Calle pez 27",
    cod_postal: 2900
  }
})
```

---

### **10. Insertar múltiples productos en la colección `Producto`**
```js
db.Producto.insertMany([
  {
    Cod_Producto: 3,
    Nombre: "Alicates",
    Precio: 10,
    Unidades: 25,
    Fabricantes: ["fab1", "fab2", "fab5"]
  },
  {
    Cod_Producto: 4,
    Nombre: "Arandela",
    Precio: 1,
    Unidades: 500,
    Fabricantes: ["fab2", "fab3", "fab4"]
  }
])
```

---

