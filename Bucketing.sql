Static Partioning Method:
************************

create table cust_trans(
cust_id STRING,  
cust_name STRING, 
odr_date STRING,
shipdt STRING,
recvd_dt STRING,
returned_dt STRING,
reason_of_return STRING
)
PARTITIONED BY(returned_or_not STRING,Courer STRING)
row format delimited fields terminated by ',';


create table cust_trans_tmp(
cust_id STRING,  
cust_name STRING, 
odr_date STRING,
shipdt STRING,
Courer STRING,
recvd_dt STRING,
returned_or_not STRING,
returned_dt STRING,
reason_of_return STRING
)
row format delimited fields terminated by ','
tblproperties("skip.header.line.count"="1");

load data inpath '/user/shwetatanwar138026/hive_part.txt' into table cust_trans_tmp;

alter table cust_trans add partition(returned_or_not='no',Courer='Fedx');

insert into table cust_trans partition(returned_or_not='no',Courer='Fedx') select cust_id ,  cust_name,odr_date ,shipdt ,recvd_dt ,returned_dt ,reason_of_return from cust_trans_tmp where 
returned_or_not='no'and Courer='Fedx';

Dynamic Partioning Method:
*************************

drop table cust_trans;
drop table cust_trans_tmp;

hdfs dfs -put '/home/shwetatanwar138026/hive_part.txt' .

create table cust_trans(
cust_id STRING,  
cust_name STRING, 
odr_date STRING,
shipdt STRING,
recvd_dt STRING,
returned_dt STRING,
reason_of_return STRING
)
PARTITIONED BY(returned_or_not STRING,Courer STRING)
row format delimited fields terminated by ',';

create table cust_trans_tmp(
cust_id STRING,  
cust_name STRING, 
odr_date STRING,
shipdt STRING,
Courer STRING,
recvd_dt STRING,
returned_or_not STRING,
returned_dt STRING,
reason_of_return STRING
)
row format delimited fields terminated by ','
tblproperties("skip.header.line.count"="1");

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=true;

load data inpath '/user/shwetatanwar138026/hive_part.txt' into table cust_trans_tmp;

insert into table cust_trans partition(returned_or_not,Courer)select cust_id ,  cust_name,odr_date ,shipdt ,recvd_dt ,returned_dt ,reason_of_return ,returned_or_not,Courer from cust_trans_tmp;


Bucketing with dynamic partitioning:
************************************
drop table cust_trans;

create table if not exists cust_trans(cust_id STRING,  
cust_name STRING, 
odr_date STRING,
shipdt STRING,
recvd_dt STRING,
returned_dt STRING,
reason_of_return STRING)partitioned by (returned_or_not STRING,Courer STRING
) clustered by(returned_dt) 
into 4 buckets stored as textfile;

insert into table cust_trans partition(returned_or_not,Courer)select cust_id ,  cust_name,odr_date ,shipdt ,recvd_dt ,returned_dt ,reason_of_return ,returned_or_not,Courer from cust_trans_tmp;

Notes:

When location is used in create table , then we need to give folder location.

When load data command is used then we can give the file name.

In static we need to give the partition name while entering the data into table.

In Dynamic we dont need to mention partition name.


