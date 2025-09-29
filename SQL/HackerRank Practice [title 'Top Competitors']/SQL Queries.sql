CREATE DATABASE HACKERRANK_PRACTICE_1;

-- we can make those tables into csv and import them into the database
-- or just do the manual query like this:

CREATE TABLE difficulty (
difficulty_level int primary key,
score int);

INSERT INTO difficulty VALUES
(1,	20),
(2,	30),
(3,	40),
(4,	60),
(5,	80),
(6,	100),
(7,	120);

CREATE TABLE submissions (
submission_id int,
hacker_id int, 
challenge_id int,
score int);

INSERT INTO submissions VALUES
(68628, 77726, 36566, 30),
(65300, 77726, 21089, 10),
(40326, 52243, 36566, 77),
(8941, 27205, 4810, 4),
(83554, 77726, 66730, 30),
(43353, 52243, 66730, 20),
(55385, 52348, 71055, 20),
(39784, 27205, 71055, 23),
(94613, 86870, 71055, 30),
(45788, 52348, 36566, 0),
(93058, 86870, 36566, 30),
(7344, 8439, 66730, 92),
(2721, 8439, 4810, 36),
(523, 5580, 71055, 4),
(49105, 52348, 66730, 0),
(55877, 57645, 66730, 80),
(38355, 27205, 66730, 35),
(3924, 8439, 36566, 80),
(97397, 90411, 66730, 100),
(84162, 83082, 4810, 40),
(97431, 90411, 71055, 30);

CREATE TABLE challenges
(challenge_id int primary key,
hacker_id int,
difficulty_level int);

INSERT INTO challenges VALUES
(4810, 77726, 4),
(21089, 27205, 1),
(36566, 5580, 7),
(66730, 52243, 6),
(71055, 52243, 2);

CREATE TABLE hackers
(hacker_id int ,
name varchar(20));

INSERT INTO hackers VALUES
(5580, 'Rose'),
(8439, 'Angela'),
(27205, 'Frank'),
(52243, 'Patrick'),
(52348, 'Lisa'),
(57645, 'Kimberly'),
(77726, 'Bonnie'),
(83082, 'Michael'),
(86870, 'Todd'),
(90411, 'Joe');

-- the answer:
SELECT 
    hacker_id, name
FROM
    (SELECT 
        s.*, c.difficulty_level, d.score AS score_max, h.name
    FROM
        Submissions s
    LEFT JOIN Challenges c ON c.challenge_id = s.challenge_id
    LEFT JOIN Difficulty d ON c.difficulty_level = d.difficulty_level
    LEFT JOIN Hackers h ON h.hacker_id = s.hacker_id) AS main_data
WHERE
    score = score_max
GROUP BY 1 , 2
HAVING COUNT(DISTINCT challenge_id) > 1
ORDER BY COUNT(DISTINCT challenge_id) DESC , 1 ASC;
