create database product;

use product;

create external table product_sale(
ID int,
product string,
buyprice float,
sellprice float,
units_purchsed int,
units_sold int,
year bigint)
row format delimited
fields terminated by ','
location '/data/test2'
tblproperties("skip.header.line.count"="1")
;
ALTER TABLE product_sale CHANGE ID ID string;

select * from product_sale limit 5;
--Calculate the Maximum Buy rate--

select max(buyprice) --12
from product_sale;

--Calculate average sell rate--
select avg(sellprice)--18.982905982905983
from product_sale;

--Calculate average buy rate--
select avg(buyprice)--7.415954415954416
from product_sale;

select max(buyprice),substr(id,1,5)
from product_sale;