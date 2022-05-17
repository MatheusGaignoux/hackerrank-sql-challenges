import pandas as pd
import os

from os.path import dirname
from pymysql import connect
from datetime import datetime

path = "/project/target/data/15_of_sql_learning_solution.csv"

def main():
    config = {
    "user": "docker",
    "password": "docker",
    "host": "127.0.0.1",
    "database": "hackerrank"
    }

    conn = connect(**config)
    # reading the tables used in the challenge from mysql database
    subs = pd.read_sql_query("select * from submissions", conn)
    hack = pd.read_sql_query("select * from hackers", conn)
    conn.close()

    # First task: find the hacker_id with most submissions per day
    hacker_recurrence = (
        subs
        .groupby(["submission_date", "hacker_id"])
        .agg({"submission_id": "count"})
        .reset_index()
        .rename(
            columns = {
                "submission_id": "qtt_submissions"
            }
        )
        .drop_duplicates()
        .sort_values(["submission_date", "qtt_submissions", "hacker_id"], ascending = [True, False, True])
    )

    hacker_recurrence["rn"] = hacker_recurrence.groupby(["submission_date"]).cumcount() + 1
    first_hacker = hacker_recurrence[hacker_recurrence["rn"] == 1][["submission_date", "hacker_id"]]

    # Sencond task: find the number of hackers who submited at least once in each preavious day
    start_date = datetime.date(datetime(2016, 3, 1))

    hacker_recurrence["hacker_count"] = hacker_recurrence.groupby(["hacker_id"]).cumcount()

    hacker_recurrence["diff"] = (
        hacker_recurrence["submission_date"]
        .apply(lambda x: (x - start_date).days)
    )

    condition = (hacker_recurrence["hacker_count"] == hacker_recurrence["diff"])

    qtt_hackers = (
        hacker_recurrence[condition]
        .groupby(["submission_date"])
        .agg({"hacker_id": "count"})
        .reset_index()
        .rename(columns = {"hacker_id": "qtt_hackers"})
    )

    # Generating the result dataframe
    df = (
        qtt_hackers
        .merge(first_hacker, on = "submission_date", how = "inner")
        .merge(hack, on = "hacker_id", how = "inner")
        .sort_values(["submission_date"])
    )

    df.to_csv(path)

if __name__ == "__main__":
    main()