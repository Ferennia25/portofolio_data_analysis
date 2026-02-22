create database payment_bank;

create table bank_accounts (
account_number int primary key,
fullname varchar(100) not null,
balance double not null);

create table transactions_record (
transaction_id int auto_increment primary key,
account_id int not null,
type varchar(20),
amount double,
timestamp datetime,
note varchar(100),
foreign key (account_id) REFERENCES bank_accounts(account_number)
);


INSERT INTO bank_accounts (account_number, fullname, balance) VALUES
(10001, 'Ferennia Putri', 1500000),
(10002, 'Rifkhi Akbar', 2750000),
(10003, 'Theo Satrya', 320000),
(10004, 'Aulia Rizkyah', 985000),
(10005, 'Ningning', 12500000),
(10006, 'Anton Ganteng', 540000),
(10007, 'Sungchan Jung', 8450000),
(10008, 'Andy Gracia', 740000),
(10009, 'Finn Wolfhard', 2130000),
(10010, 'Sadie Sink', 910000);

select * from bank_accounts;
select * from transactions_record;



