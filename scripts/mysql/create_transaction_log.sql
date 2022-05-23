create table if not exists hackerrank.transaction_log (
    id integer not null,
    paid_by text not null,
    paid_to text not null,
    amount integer,
    transacted_on date
);

load data infile "/project/data/transaction_log.csv" into table hackerrank.transaction_log
fields terminated by ","
enclosed by ''
lines terminated by "\n"
;