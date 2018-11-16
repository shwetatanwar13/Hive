 hadoop fs -cp '/data/bdhs/employees' .

create table employee(
    name STRING,
    department STRING,
    somedate DATE)
    PARTITIONED BY(year STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

load data inpath '/user/shwetatanwar138026/employees/2015.csv' into table employee partition (year=2015);
load data inpath '/user/shwetatanwar138026/employees/2012.csv' into table employee partition (year=2012);




create table employee(
    name STRING,
    department STRING,
    somedate DATE)
    PARTITIONED BY(year int,month int)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

load data inpath '/user/shwetatanwar138026/employees/2015.csv' into table employee partition (year=2015,month=10);
load data inpath '/user/shwetatanwar138026/employees/2012.csv' into table employee partition (year=2012,month=11);

create table employee_tmp(
    name STRING,
    department STRING,
    somedate DATE)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    location '/user/shwetatanwar138026/employees';

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=true;

create table employee(
    name STRING,
    somedate DATE)
    PARTITIONED BY(department STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

insert into table employee partition(department) select name,somedate,department from employee_tmp;

alter table employee drop partition(department='2015-03-19');
alter table employee add partition(department='IT');


 hdfs dfs -ls /apps/hive/warehouse/hive_tutorial_st.db/employee

 hdfs dfs -mkdir /apps/hive/warehouse/hive_tutorial_st.db/employee/department=Cleaning

This partition is nor recognized by hive.
To add to hive metadata

Approach 1: add partition using alter
hive> alter table employee add partition(department='Cleaning');

Approach 2:msck repair 
hive> msck repair table employee;
Partitions not in metastore:    employee:department=Production
Repair: Added partition to metastore employee:department=Production


show partitions employee;