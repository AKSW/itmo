#Helpful Oracle queries on the itmo database (Oracle 11g)

#General Stuff
# get version (should be 11g)
select * from v$version;
# get all tables
select * from all_tables;
# laboratory table
select * from sem_list_info;
# split countries from laboratories into multiple rows
select NET_DEP_ID,trim(regexp_substr (COUNTRY, '[^|]+', 1, level)) COUNTRY
from SEM_LIST_INFO 
connect by level <= length (regexp_replace (COUNTRY, '[^|]+'))  + 1
# distinct list of all countries
select distinct trim(regexp_substr (COUNTRY, '[^|]+', 1, level)) COUNTRY
from SEM_LIST_INFO 
connect by level <= length (regexp_replace (COUNTRY, '[^|]+'))  + 1
