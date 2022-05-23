from python:3.9

run mkdir -p /project/target/data
run mkdir /project/solutions

copy requirements.txt /project/requirements.txt
copy solutions/pandas /project/solutions/

run pip install -r /project/requirements.txt

cmd python3 /project/solutions/15_days_of_sql_learning.py
