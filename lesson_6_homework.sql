--task3  (lesson6)
--������������ �����: ������� ����� ������ �������� (��, ��-�������� ��� ��������), �������� ����� ������� ����. �������: model

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
-- ������������ �����: ������� ������� all_products_with_index_task5 ��� ����������� ���� ������ �� ����� code (union all) � ������� ���� (flag) �� ���� > ������������ �� ��������. ����� �������� ��������� (����� ������� �������) �� ������ ��������� �������� � ������� ����������� ���� (price_index). �� ����� price_index ������� ������
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