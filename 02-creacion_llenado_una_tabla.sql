-- CREACION DE LA BASDE DE DATOS TIENDA1
 -- SQL LDD
-- crear base de datos 
create database tienda1;
use tienda1;

create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria
primary key (categoriaid),
constraint unico_nombre
unique (nombre)
);

insert into categoria
values (1, 'carnes frias');

insert into categoria( categoriaid, nombre)
values (2, 'Linea Blanca');

insert into categoria( nombre, categoriaid)
values ('Vinos y Licores',3);

insert into categoria
values (5 , 'bebidas'),
(6, 'dulces'),
(7, 'lacteos');

insert into categoria (nombre, categoriaid)
values ('panaderia', 8),
('zapateria' , 9),
('jugeteria', 10);



select * from categoria;
insert into categoria
values (3, 'Muneca Vieja');
/*
create table producto(
productoid int not null,
nombre varchar(30) not null,
descripcion varchar (100),
precio double not null,
existencia int not null

);
*/