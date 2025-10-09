![Image](https://github.com/user-attachments/assets/c34dfb21-6cf4-448e-ab00-9e6ae33fdebf)

### Hi! This is Ferennia

**I want to share my ideas on how I solved one of the HackerRank SQL Practices. This problem is quite interesting because we have to use the join and subquery method simultaneously. I hope my thoughts and solutions can help you learn more about SQL!** ❤

**-- the task**

Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

Input Format

The following tables contain contest data:

Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker.

![Image](https://github.com/user-attachments/assets/86670ea4-d2e9-42d4-aa28-1005552f6ee2)

Difficulty: The difficult_level is the level of difficulty of the challenge, and score is the maximum score that can be achieved for a challenge at that difficulty level.

![Image](https://github.com/user-attachments/assets/4cb02416-de98-4a88-bf10-17808b473290)

Challenges: The challenge_id is the id of the challenge, the hacker_id is the id of the hacker who created the challenge, and difficulty_level is the level of difficulty of the challenge.

![Image](https://github.com/user-attachments/assets/eb29974b-084b-40c6-88cc-b08408eee64c)

Submissions: The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, challenge_id is the id of the challenge that the submission belongs to, and score is the score of the submission.

![Image](https://github.com/user-attachments/assets/546ceebd-2e0b-488a-8951-af5ce92be849)

**-- my answer**

I usually make points on whatever steps and output I have to make every time I practice on HackerRank. In this case, we only need hacker_id and name columns, but actually, we can get those columns only from the table that has been joined from all the tables that are given. We get Hackers, Difficulty, Challenges, and Submissions table. If we look closely, every table has its own primary and foreign keys, which can connect to the other table. In my solution, I connect the Submissions table to the Challenges table on challenge_id cause both tables have the column. I also connect the Submissions table to the Hackers table on hacker_id. Last, I connect the Challenges table, which has been joined to the Submissions table, to the Difficulty table on difficulty_level.

Now, imagine the result of all the joined tables. We have a table that contains submission_id, hacker_id, challenge_id, score (from the Submissions table, which is the score of hackers who got in every submission), difficulty_level, score as score_max (from the Difficulty table, which is the maximum score that can be achieved for a challenge at that difficulty level), and name column.

After we get that main table, we need to filter it as the requirements asked on the question. The output must be the hacker_id and name who achieved the maximum score for more than one challenge. Also, we should order the data by total number of challenges descending and by hacker_id ascending. Here is the query I have made.

![Image](https://github.com/user-attachments/assets/92b5671c-a287-4983-b35f-7275ecaef6ff)

As I said before, we can get the hacker_id and name columns from the table containing all the tables. After that, we filter the subquery table, where the score is the maximum score and the challenges are more than one. We also order by the number of challenges descending and hacker_id ascending. Don’t forget to group them by hacker_id and name because we make an aggregation by counting the challenges.


![Image](https://github.com/user-attachments/assets/646ed16d-ae9c-40f5-a2e4-5d2f5cc8be83)
