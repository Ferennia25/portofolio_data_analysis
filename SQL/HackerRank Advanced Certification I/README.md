![Image](https://github.com/user-attachments/assets/6eaab470-8957-4119-bf5c-79a76e753eab)

### Hi! This is Ferennia

I want to share my ideas on how I solved the problem of the HackerRank SQL Advanced Certification. I think this problem was the most unique and challenging compared to the other one. I hope my thoughts and solutions help you prepare for the test! ❤

## Crypto Market Transactions Monitoring

As part of a cryptocurrency trade monitoring platform, create a query to return a list of suspicious transactions. Suspicious transactions are defined as:

- A series of two or more transactions occur at intervals of an hour or less
- They are from the same sender
- The sum of transactions in sequence is 150 or greater

A sequence of suspicious transactions may occur over time periods greater than one hour.
As an example, there are 5 transactions from one sender for 30 each. They occur at intervals of less than an hour between from 8 AM to 11 AM. These are suspicious and will all be reported as one sequence that starts at 8 AM, ends at 11 AM, with 5 transactions that sum to 150.

The result should have the following columns:
sender, sequence_start, sequence_end, transactions_count, transactions_sum

- sender is the sender’s address.
- sequence_start is the timestamp of the first transaction in the sequence.
- sequence_end is the timestamp of the last transaction in the sequence.
- transactions_count is the number of transactions in the sequence.
- transactions_sum is the sum of transaction amounts in the sequence, to 6 places after the decimal.

Order the data ascending, first by sender, then by sequence_start, and finally by sequence_end.

![Image](https://github.com/user-attachments/assets/c4049c2b-b280-4517-bf01-2710280987d6)

We’re gonna use this simple one table. But believe me, some steps must be through to get the final answer. The first column has dt column with the VARCHAR(19) data type. It describes the transaction timestamp. Next, we have the sender column, a VARCHAR(19), used to title the sender address. The third column is the recipient column, also a VARCHAR(49). It is a recipient address. The last column is amount with the DECIMAL(6,9) data type, a transaction amount.

![Image](https://github.com/user-attachments/assets/6faed62f-85a4-467f-a245-78acdbbbc28a)

![Image](https://github.com/user-attachments/assets/29bdefe6-a6c7-40e5-9105-62e05739ccb8)

These are the sample data on the test. But I already have the dummy data with 100 rows, that’s similar enough.

**Step 1.** Get the previous datetime, the time difference between the datetime and the previous datetime, and the amount each sender spent. All those categories are partitioned by sender and ordered by datetime. I also made them all become one temporary table named time_diff_data.

![Image](https://github.com/user-attachments/assets/e46398fc-5b16-4d37-84f9-6ca78d6d33be)

We can also see the result of the query above with,

select * from time_diff_data;

The result must be like this,

![Image](https://github.com/user-attachments/assets/b0f71d32-9c20-4ddf-92a5-f7a670d7f286)

**Step 2.** As stated before, suspicious transactions are defined as two or more transactions occurring at intervals of an hour or less. Filter the time_diff_data table with a time difference less than or equal to an hour, represented by ‘01:00:00’ VARCHAR. We can name that temporary table by suspicious_transactions.

![Image](https://github.com/user-attachments/assets/11dad47c-b84b-4d7e-bc07-277fe8857f20)

We can also see the result of the query above with,

select * from suspicious_transactions;

The result must be like this,

![Image](https://github.com/user-attachments/assets/1d5b4e22-a7ee-4d73-ab9f-01294e7aa82d)

**Step 3.** One of our main purposes is to get transactions_count. In order to get the number of transactions for each sender, we can do titling every row partitioned by sender. But we actually still haven’t got the counts yet cause every row contains two transactions which are shown by datetime and previous datetime. So, in this step, we just get the number of each row partitioned by sender.

![Image](https://github.com/user-attachments/assets/f6830067-738b-427a-8bbd-ee844fd8ec8e)

We can also see the result of the query above with,

select * from suspicious_transactions_w_row_numbers;

The result must be like this,

![Image](https://github.com/user-attachments/assets/ca948fc9-4fc2-4aef-a957-79cf0f3b7ce0)

**Step 4.** The last step is collecting all the required columns, such as sender, sequence_start, which we get from the minimum of previous_dt, sequence_end, which is the maximum of datetime (dt), transaction_count which represents the total rows for each sender plus 1 (because we use lap function to get previous_dt and each row has two data times so that we have to add 1) , and the amount of each sender spent that we already got at the first step. All the queries must be grouped by sender and total_amount_per_sender because we do the aggregation on sequence_start, sequence_end,and transactions_count. Also, do not forget to limit the total number of transactions_count that we already aggregated to equal or more than 2 transactions and total_amount_per_sender is equal or more than 150 .

![Image](https://github.com/user-attachments/assets/74d1c7f2-4b62-418e-9a24-9c58350edbe2)

The result must be like this,

![Image](https://github.com/user-attachments/assets/854308ea-4042-43c6-9a0d-a3d209ce55d3)

After all, we finally got the result we needed. As you guys see here, all of the suspicious transactions happened 25 times with five different senders, and most of the time, the fraud started at 8 a.m. and happened on five days in a row.
