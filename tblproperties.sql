CREATE DATABASE mydb;

CREATE TABLE IF NOT EXISTS mydb.employees2 (  
name STRING COMMENT 'Employee name', 
salary FLOAT  COMMENT 'Employee salary',  
subordinates ARRAY<STRING> COMMENT 'Names of subordinates', 
deductions MAP<STRING, FLOAT>  COMMENT 'Keys are deductions names, values are percentages',  
address STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>  COMMENT 'Home address') 
COMMENT 'Description of the table' 
LOCATIOn '/data'
TBLPROPERTIES ('creator'='me', 'created_at'='2012-01-02 10:00:00');

describe extended mydb.employees;