-- Day 1 

create table cust_alter(
cust_id INT PRIMARY KEY,
cust_name VARCHAR(20)
);

ALTER TABLE cust_alter ADD phone VARCHAR(15);
ALTER TABLE cust_alter mODIFY phone VARCHAR(25);
ALTER TABLE cust_alter drop phone ;
ALTER TABLE cust_alter add constraint primary key(cust_id);
ALTER TABLE CUST_ALTER DROP PRIMARY KEY;

 select * from cust_alter;
 
 drop database dem0;

 create database Demo1;
use demo1;
CREATE TABLE products_op (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT,
    quantity INT
);
INSERT INTO products_op (product_id, product_name, price, quantity) VALUES
(1, 'Laptop', 50000, 2),
(2, 'Mouse', 500, 10),
(3, 'Keyboard', 1500, 5);
select * from products_op;
select product_name, price * quantity as total from products_op;
SELECT product_name, price / quantity AS unit_div FROM products_op;
SELECT product_name, price / NULLIF(quantity, 0) as zero_handling FROM products_op;

CREATE TABLE emp_rel (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT
);
INSERT INTO emp_rel (emp_id, emp_name, salary) VALUES
(1, 'Arjun Raj', 60000),
(2, 'Priya Nair', 45000),
(3, 'Ramesh Kumar', 70000);

select * from emp_rel;
select * from emp_rel where salary=45000;
SELECT CONCAT(emp_name, ' with ', salary) AS full_info
FROM emp_rel;


SELECT *
FROM emp_rel c
WHERE EXISTS (
    SELECT 1
    FROM emp_rel e
    WHERE e.emp_name = "Priya Nair"
);

create table orders(
	order_id INT,
    order_date timestamp,
    order_customer_id int,
    order_status varchar(20)
);
DESC ORDERS;
insert into orders values
(1,'2013-07-25 00:00:00.0',11599,'CLOSED'),
(2,'2013-07-25 00:00:00.0',256,'PENDING_PAYMENT'),
(3,'2013-07-25 00:00:00.0',12111,'COMPLETE'),
(4,'2013-07-25 00:00:00.0',8827,'CLOSED'),
(5,'2013-07-25 00:00:00.0',11318,'COMPLETE'),
(6,'2013-07-25 00:00:00.0',7130,'COMPLETE'),
(7,'2013-07-25 00:00:00.0',4530,'COMPLETE'),
(8,'2013-07-25 00:00:00.0',2911,'PROCESSING'),
(9,'2013-07-25 00:00:00.0',5657,'PENDING_PAYMENT'),
(10,'2013-07-25 00:00:00.0',5648,'PENDING_PAYMENT'),
(11,'2013-07-25 00:00:00.0',918,'PAYMENT_REVIEW'),
(12,'2013-07-25 00:00:00.0',1837,'CLOSED'),
(13,'2013-07-25 00:00:00.0',9149,'PENDING_PAYMENT'),
(14,'2013-07-25 00:00:00.0',9842,'PROCESSING'),
(15,'2013-07-25 00:00:00.0',2568,'COMPLETE'),
(16,'2013-07-25 00:00:00.0',7276,'PENDING_PAYMENT'),
(17,'2013-07-25 00:00:00.0',2667,'COMPLETE'),
(18,'2013-07-25 00:00:00.0',1205,' CLOSED'),
(19,'2013-07-25 00:00:00.0',9488,'PENDING_PAYMENT'),
(20,'2013-07-25 00:00:00.0',9198,'PROCESSING')
;
select * from orders;
select distinct order_status from orders;
select *  from orders where order_status = 'CLOSED' or order_status = 'COMPLETE';
SELECT count(order_status) as count_of_order from orders group by order_status;

CREATE TABLE dept (
    deptno INT,
    dname  VARCHAR(14),
    loc    VARCHAR(13)
);
CREATE TABLE emp (
    empno    INT,
    ename    VARCHAR(10),
    job      VARCHAR(9),
    mgr      INT,
    hiredate DATE ,
    sal      DECIMAL(7,2) ,
    comm     DECIMAL(7,2),
    deptno   INT
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

select * from emp;
select * from emp where sal*12>30000;
select * from emp where job in ('ANALYST','SALESMAN');
select distinct job as unique_jobs from emp;
select ename,REPLACE(job,'SALESMAN','MARKETING') AS new_job from emp where job = 'SALESMAN';
select * from emp order by sal desc limit 1;
select * from emp order by sal limit 1;
select count(empno) as total_employees from emp;
select distinct dname from dept;
select sum(sal) as total_sal from emp e join dept d on e.deptno = d.deptno group by d.dname;