-- Day 2

use Demo1;
CREATE TABLE IF NOT EXISTS cust_notnull (
    customer_id INT NOT NULL,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100)
);
desc Demo1.cust_notnull;

INSERT INTO cust_notnull (customer_id, customer_name, email)
VALUES (1, 'Arjun Sharma', 'arjun@example.com');

INSERT INTO cust_notnull (customer_id, customer_name)
VALUES (2, 'Priya Nair');

select * from cust_notnull;

INSERT INTO cust_notnull (customer_id, customer_name)
VALUES (3, 'ramesh@example.com');

create table cust_default(
cust_id int primary key,
cust_name varchar(20) not null default "user121",
status varchar(20) not null default "Active");

INSERT INTO cust_default (cust_id, cust_name)
VALUES (1, 'Meena Kumari');

INSERT INTO cust_default (cust_id, status)
VALUES (2, 'Inactive');

INSERT INTO cust_default (cust_id, cust_name)
VALUES (3, 'Raj Kamal');

select * from cust_default;

INSERT INTO cust_default (cust_id, cust_name)
VALUES (4, 'Ananya Kadam');

create table cust_unique(cust_id int primary key, cust_name varchar(20) not null, cust_email varchar(20) unique);

INSERT INTO cust_unique (cust_id, cust_name, cust_email)
VALUES (1, 'Kavita Pal', 'kavita@example.com');

INSERT INTO cust_unique (cust_id, cust_name, cust_email)
VALUES (2, 'Neha Gupta', NULL);

INSERT INTO cust_unique (cust_id, cust_name, cust_email)
VALUES (4, 'Manoj Verma', 'manoj@example.com');
select * from cust_unique;

CREATE TABLE prod_pk (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL
);
desc prod_pk;
INSERT INTO prod_pk (product_id, product_name)
VALUES (1, 'Laptop');

INSERT INTO prod_pk (product_id, product_name)
VALUES (2, 'Mouse');
select * from prod_pk;

INSERT INTO prod_pk
VALUES (4, 'Another Mouse');

CREATE TABLE cust_fk (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL
);
create table order_table(order_id int primary key, customer_id int, order_date date ,foreign key(customer_id) references cust_fk(customer_id));
desc order_table;


CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dname  VARCHAR(14) NOT NULL,
    loc    VARCHAR(13)
);
drop table emp;
CREATE TABLE emp (
    empno    INT PRIMARY KEY,
    ename    VARCHAR(10) NOT NULL,
    job      VARCHAR(9)  NOT NULL,
    mgr      INT,
    hiredate DATE NOT NULL,
    sal      DECIMAL(7,2) CHECK (sal > 0),
    comm     DECIMAL(7,2),
    deptno   INT,
    CONSTRAINT fk_deptno FOREIGN KEY (deptno) REFERENCES dept(deptno)
);
INSERT INTO dept VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','CHICAGO'),
(40,'OPERATIONS','BOSTON');
INSERT INTO emp VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800.00,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600.00,300.00,30),
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250.00,500.00,30),
(7566,'JONES','MANAGER',7839,'1981-04-02',2975.00,NULL,20),
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250.00,1400.00,30),
(7698,'BLAKE','MANAGER',7839,'1981-05-01',2850.00,NULL,30),
(7782,'CLARK','MANAGER',7839,'1981-06-09',2450.00,NULL,10),
(7788,'SCOTT','ANALYST',7566,'1982-12-09',3000.00,NULL,20),
(7839,'KING','PRESIDENT',NULL,'1981-11-17',5000.00,NULL,10),
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500.00,0.00,30),
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100.00,NULL,20),
(7900,'JAMES','CLERK',7698,'1981-12-03',950.00,NULL,30),
(7902,'FORD','ANALYST',7566,'1981-12-03',3000.00,NULL,20),
(7934,'MILLER','CLERK',7782,'1982-01-23',1300.00,NULL,10);

select ename, sal, sal*12 as annual_salary from emp where sal*12>30000;
select deptno, count(*) as emp_count from emp group by deptno having emp_count>=3 order by emp_count desc;

select * from emp where job in ('SALESMAN','ANALYST');
SELECT * FROM emp where ename like "M%";
SELECT * FROM emp WHERE YEAR(hiredate) = '1981';
select deptno,max(sal) as maximum_sal, min(sal) as minimum_sal from emp group by deptno;
select * from emp where DAYNAME(hiredate)='Thursday';
select deptno, count(*) as couting from emp group by deptno having count(*)>3;
SELECT empno,ename, TIMESTAMPdiff(MONTH,hiredate,curdate()) as month_worked from emp;
    
select count(*) from emp;

SELECT ename, sal, d.deptno, dname, loc FROM emp e join dept d on e.empno = d.deptno;

select * from emp where sal > (select avg(sal) as avg_sal from emp);

select row_number() over() as row_numbering, sal, ename from emp;

-- Case Study

create database retail_db;
use retail_db;
show tables;

desc categories;
desc customers;
desc departments;
desc order_items;
desc orders;
desc products;

select count(*) from categories;
select count(*) from customers;
select count(*) from departments;
select count(*) from products;
select count(*) from order_items;
select count(*) from orders;

select * from order_items limit 15;

select order_date, count(*) as peak_order from orders group by order_date order by peak_order desc limit 1;
select order_date, count(*) as peak_order from orders group by order_date having peak_order> 120;
select sum(order_item_subtotal) as revenue from order_items group by order_item_order_id having order_item_order_id = 2;
select sum(order_item_subtotal) as revenue from order_items group by order_item_order_id;
select monthname(order_date), count(*) from orders group by monthname(order_date) order by monthname(order_date);