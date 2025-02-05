/* consultas de agregado 
solo devuelven un solo registrp

sum, avg, count, count(*), mas y min

cuantos clientes tengo
*/

select count(*) as [Numero de Clientes] from Customers

-- cuantas regiones hay
select count(Region) as [Regiones] from Customers


select count (distinct region) as [Regiones]
from Customers
where Region is not null
