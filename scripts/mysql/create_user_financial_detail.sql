create table if not exists hackerrank.user_financial_detail (
    id integer not null,
    first_name text not null,
    last_name text not null,
    vpa text not null,
    credit_limit integer
);

load data infile "/project/data/user_financial_detail.csv" into table hackerrank.user_financial_detail
fields terminated by ","
enclosed by ''
lines terminated by "\n"
;