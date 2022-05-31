drop table if exists hackerrank_db.submissions;
create table hackerrank_db.submissions (
    submission_date date not null,
    submission_id integer not null,
    hacker_id integer not null,
    score integer
)
;

load data infile "/project/data/submissions.csv" into table hackerrank_db.submissions
fields terminated by ','
enclosed by ''
lines terminated by '\n'
;