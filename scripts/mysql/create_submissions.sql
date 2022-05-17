drop table if exists hackerrank.submissions;
create table hackerrank.submissions (
    submission_date date not null,
    submission_id integer not null,
    hacker_id integer not null,
    score integer
)
;

load data infile "/project/data/hackers_table.csv" into table hackerrank.submissions
fields terminated by ','
enclosed by ''
lines terminated by '\n'
ignore 1 rows
;