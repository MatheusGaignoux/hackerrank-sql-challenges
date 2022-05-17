drop table if exists hackerrank.hackers;
create table hackerrank.hackers (
    hacker_id integer not null,
    `name` text not null 
);

load data infile "/project/data/hackers_name.csv" into table hackerrank.hackers
fields terminated by ','
enclosed by ''
lines terminated by '\n'
ignore 1 rows
;