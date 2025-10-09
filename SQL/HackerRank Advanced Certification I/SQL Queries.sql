create database portofolio_sql;

select * from transactions;

-- the query in cte version
with time_diff_data as (
select 
	dt ,
    lag(dt) over (partition by sender order by dt) previous_dt,
    timediff(dt,lag(dt) over (partition by sender order by dt)) timedif,
    sender,
    recipient,
    amount,
    sum(amount) over (partition by sender) total_amount_per_sender
from transactions),
suspicious_transactions as (
select *
from time_diff_data
where timedif <= '01:00:00'),
suspicious_transactions_w_row_numbers as (
select 
	*, 
    row_number() over (partition by sender order by dt) number
from suspicious_transactions)
select 
	sender,
    min(previous_dt) sequence_start,
    max(dt) sequence_end,
    max(number)+1 transactions_count,
    round(total_amount_per_sender,6) transactions_sum
from suspicious_transactions_w_row_numbers
where round(total_amount_per_sender,6) >= 150
group by 1,5 having transactions_count >= 2
order by 1,2,3 asc;


-- the query in temporary table version

create temporary table time_diff_data
select 
	dt ,
    lag(dt) over (partition by sender order by dt) previous_dt,
    timediff(dt,lag(dt) over (partition by sender order by dt)) timedif,
    sender,
    recipient,
    amount,
    sum(amount) over (partition by sender) total_amount_per_sender
from transactions;

create temporary table suspicious_transactions
select *
from time_diff_data
where timedif <= '01:00:00';

create temporary table suspicious_transactions_w_row_numbers
select 
	*, 
    row_number() over (partition by sender order by dt) number
from suspicious_transactions;

select 
	sender,
    min(previous_dt) sequence_start,
    max(dt) sequence_end,
    max(number)+1 transactions_count,
    round(total_amount_per_sender,6) transactions_sum
from suspicious_transactions_w_row_numbers
where round(total_amount_per_sender,6) >= 150
group by 1,5 having transactions_count >= 2
order by 1,2,3 asc;


