create database if not exists Hive_DB1 comment "This is a hive database";

describe database extended hive_db;
show databases;
set hive.metastore.warehouse.dir;

create table if not exists cust_trx(
cust_id string,
cust_name string,
odr_date string,
shipdt string,
Courer string,
recvd_dt string,
returned string,
returned_dt string,
reason_of_return string)
row format delimited
fields terminated by ','
tblproperties("skip.header.line.count"="1");

drop table cust_trx;

load data local inpath "/home/cloudera/data/hive/"
into table cust_trx;

select * from cust_trx limit 5;
