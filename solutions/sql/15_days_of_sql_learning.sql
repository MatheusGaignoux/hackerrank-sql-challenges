insert into hackerrank_db.15_days_of_sql_learning 
select submission_date, 
	(
		select count(distinct y.hacker_id)
		from submissions y
		where 1 = 1
			and (
				select count(distinct z.submission_date)
				from submissions z
				where 1 = 1
					and y.hacker_id = z.hacker_id 
					and z.submission_date < y.submission_date
			) = datediff(y.submission_date, '2016-03-01')
			and y.submission_date = x.submission_date
		group by y.submission_date
	) as qtt_hackers,
	(
		select hacker_id
		from submissions w
		where 1 = 1
			and w.submission_date = x.submission_date
		group by hacker_id, submission_date
		order by submission_date, count(submission_id) desc, hacker_id asc
		limit 1
	) as first_hacker_id,
	(
		select name
		from hackers
		where 1 = 1 
			and hacker_id = first_hacker_id	
	) as first_hacker_name,
	'airflow-mysql-query-type' as job_type,
	current_timestamp() as trigged_at
from (select distinct submission_date from submissions) x
group by submission_date
;
