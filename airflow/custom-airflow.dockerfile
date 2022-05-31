from python:3.9

arg airflow_version=2.3.1 
env AIRFLOW_HOME="/airflow"

run mkdir -p /airflow/dags && \
    mkdir -p /target/data

copy airflow/config /airflow
copy airflow/init.sh /airflow/init.sh
copy requirements.txt /requirements.txt
run chmod a+x /airflow/init.sh

run apt-get update && \
    apt install -y postgresql-client && \
    pip install apache-airflow==${airflow_version} \
    --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.3.1/constraints-3.7.txt" && \
    pip install 'apache-airflow[postgres]' && \
    pip install apache-airflow-providers-mysql==2.2.3 && \
    pip install -r /requirements.txt
    
expose  8080

cmd /airflow/init.sh
