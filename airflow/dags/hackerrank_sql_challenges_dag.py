from airflow.models import DAG
from airflow.providers.mysql.operators.mysql import MySqlOperator
from datetime import datetime

create_table_file = open("/solutions/sql/create_table_15_days_of_sql_learning.sql", "r")
insert_into_table_file = open("/solutions/sql/15_days_of_sql_learning.sql", "r")

default_args = {
    "start_date": datetime(2022, 5, 30),
}

with DAG("hackerrank_sql_challenges_dag", schedule_interval = "@daily",
         default_args = default_args,
          catchup = False) as dag:

    create_table_15_days_of_sql_learning = MySqlOperator(
        task_id = "create_table_15_days_of_sql_learning",
        sql = create_table_file.read(),
        mysql_conn_id = "hackerrank_db_mysql"
    )

    insert_into_table_15_days_of_sql_learning = MySqlOperator(
        task_id = "insert_into_table_15_days_of_sql_learning",
        sql = insert_into_table_file.read(),
        mysql_conn_id = "hackerrank_db_mysql"
    )

    create_table_15_days_of_sql_learning >> insert_into_table_15_days_of_sql_learning
