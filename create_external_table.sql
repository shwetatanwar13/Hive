create external table airport_code(
city string,
state string,
country string,
IATA string)
row format delimited fields terminated by '\t'
location '/user/cloudera/data';