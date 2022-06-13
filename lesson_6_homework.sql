--task3  (lesson6)
--Компьютерная фирма: Найдите номер модели продукта (ПК, ПК-блокнота или принтера), имеющего самую высокую цену. Вывести: model

select model, price_max, price
from 
(
select *,
row_number() over (order by price desc) as price_max
from
(select product.model, maker, price, product.type 
from 
(
 select code, model, price 
   from pc 
   union all  
    select code, model, price 
    from printer  
   union all  
    select code, model, price 
    from laptop   
    ) as foo 
    join product   
    on product.model = foo.model) as max) as aa
    where price_max=1
    
    --task5  (lesson6)
-- Компьютерная фирма: Создать таблицу all_products_with_index_task5 как объединение всех данных по ключу code (union all) и сделать флаг (flag) по цене > максимальной по принтеру. Также добавить нумерацию (через оконные функции) по каждой категории продукта в порядке возрастания цены (price_index). По этому price_index сделать индекс
 create table all_products_with_index_task5 as 
 select product.model, maker, price, type, 
 case  
 when price > (select max(price) from printer) then 1 
 else 0 
 end flag 
 from  
 (select code, model, price 
 from pc  
 union all 
 select code, model, price 
 from laptop l  
 union all 
 select code, model, price 
 from printer) all_products 
 join product  
 on all_products.model = product.model; 


select * 
from 
 ( 
 select *, 
 row_number() over (partition by type order by price aSC) as price_index 
 from 
all_products_with_index_task5) foo

create index price_index on all_products_with_index_task5 (price)