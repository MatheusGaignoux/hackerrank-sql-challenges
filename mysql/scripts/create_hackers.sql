drop table if exists hackerrank_db.hackers;
create table hackerrank_db.hackers (
    hacker_id integer not null,
    `name` text not null 
);

load data infile "/project/data/hackers.csv" into table hackerrank_db.hackers
fields terminated by ','
enclosed by ''
lines terminated by '\n'
;