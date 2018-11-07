create database movielens;
CREATE EXTERNAL TABLE IF NOT exists movielens.sp_ratings ( userid INT, 
                                           movieid INT, 
                                           tstamp BIGINT 
                          ) PARTITIONED BY (rating INT)
                            ROW FORMAT DELIMITED 
                            FIELDS TERMINATED BY '\t'
                            STORED AS parquet; 
                            
LOAD DATA INPATH '/data/test1/movie' INTO TABLE sp_ratings PARTITION (rating=1);

select * from movielens.sp_ratings
where rating=1;

drop table movielens.sp_ratings;

create EXTERNAL TABLE 
 IF NOT exists movielens.sp_ratings_stg (userid INT, 
                             movieid INT, 
                             rate int,
                             tstamp BIGINT
                                           )
 ROW FORMAT DELIMITED 
 FIELDS TERMINATED BY '\t' ;
 
 alter table movielens.sp_ratings_stg change column rate rating int;
 
 load data inpath '/data/test1'
 into table movielens.sp_ratings_stg;
 
 select * from movielens.sp_ratings_stg limit 5;
 
insert into table movielens.sp_ratings partition(rating)
select userid,movieid,
tstamp,rating from movielens.sp_ratings_stg
where rating=2;

ALTER TABLE movielens.sp_ratings ADD PARTITION( rating= 1 );
set hive.exec.dynamic.partition.mode=nonstrict;

SHOW PARTITIONS movielens.sp_ratings;
                                           