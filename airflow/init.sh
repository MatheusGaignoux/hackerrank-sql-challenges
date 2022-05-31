#!/bin/bash

PGPASSWORD=airflow_pass psql \
    -U airflow_user airflow_db \
    -h airflow-metadata-postgres \
    -p 5432 \
    -c "select count(tablename) from pg_catalog.pg_tables where tableowner = 'airflow_user' and schemaname not in ('pg_catalog', 'information_schema')" > count.file

number_of_tables=$(sed -n 3p count.file | tr -d ' ')

if [ ${number_of_tables} -ge 1 ]
then {
    echo "Metastore is already defined. Passing."
}
else {
    echo "First execution. Initiating the metastore DB, creating an admin user and a connection."
    airflow db init
    airflow users create -u admin -p admin -f admin -l admin -r Admin -e adimin@airflow.com
}
fi
