CREATE TABLE Dept (
    Deptno INT PRIMARY KEY,
    Deptname VARCHAR(255) NOT NULL
);

INSERT INTO Dept (Deptno, Deptname) VALUES
(10, 'ACCOUNTING'),
(20, 'RESEARCH'),
(30, 'SALES');

SELECT * FROM DEPT;
SELECT * FROM EMPLOYEE;

CREATE TABLE Employee (
    Empno INT PRIMARY KEY NOT NULL,
    Ename VARCHAR(255) NOT NULL,
    Job VARCHAR(255) DEFAULT 'Clerk',
    Manager INT,
    Hiredate DATE,
    Salary DECIMAL(10, 2) CHECK (Salary > 0),
    Commission DECIMAL(10, 2),
    Deptno INT,
    FOREIGN KEY (Deptno) REFERENCES Dept(Deptno)
);

INSERT INTO Employee (Empno, Ename, Job, Manager, Hiredate, Salary, Commission, Deptno) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1987-05-23', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);


DESC EMPLOYEE;


-- QUEREY ONE : 3.	List the Names and salary of the employee whose salary is greater than 1000

SELECT ENAME,SALARY FROM EMPLOYEE WHERE SALARY > 1000;


-- QUEREY TWO : 4 4.	List the details of the employees who have joined before end of September 81

SELECT * FROM EMPLOYEE WHERE HIREDATE < "1981-09-30";


-- QUEREY THREE : 5 5.	List Employee Names having I as second character

SELECT ENAME FROM employee WHERE ENAME LIKE "_I%";


-- QUEREY FOUR : 6 6.	List Employee Name, Salary, Allowances (40% of Sal), P.F. (10 % of Sal) and Net Salary. Also assign the alias name for the columns

SELECT ENAME, SALARY , (SALARY * 0.40) AS ALLOWANCE , (SALARY *0.10 ) AS PF , ((SALARY) - ((SALARY * 0.40)+(SALARY *0.10 ))  ) AS NET_SALARY FROM EMPLOYEE;


-- QUEREY FIVE : 7 List Employee Names with designations who does not report to anybody

SELECT * FROM EMPLOYEE WHERE MANAGER IS NULL;


-- QUEREY SIX : 8 8.	List Empno, Ename and Salary in the ascending order of salary

SELECT EMPNO , ENAME , SALARY FROM EMPLOYEE 
ORDER BY SALARY ASC;



-- QUEREY SEVEN : 9 9.	How many jobs are available in the Organization 

SELECT count(DISTINCT JOB) AS AVAILABLE_JOBS FROM EMPLOYEE ;



-- QUEREY EIGHT : 10 10.	Determine total payable salary of salesman category

SELECT SUM(SALARY) FROM EMPLOYEE WHERE JOB = "SALESMAN";


-- QUEREY NINE `11.	List average monthly salary for each job within each department   

select deptno, avg(salary) as avg_salary from employee
group by deptno  ;


-- querey ten : 12 12.	Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working
select e.ename, e.salary , d.deptname from employee as e
inner join 
dept as d  on  e.DEPTNO = d.deptno;


-- querey eleven : 13 Create the Job Grades Table as below

create table job_grades(
grade varchar(10),
highest_salary int,
lowest_salary int);


insert into job_grades values 
('A', 1000.00, 2999.99),
('B', 3000.00, 4999.99),
('C', 5000.00, 6999.99),
('D', 7000.00, 9999.99),
('E', 10000.00, 14999.99);

select * from job_grades;
select * from employee;

-- Querey : 14.	Display the last name, salary and  Corresponding Grade

select e.ename , e.salary , j.grade from employee as e
join
job_grades as j 
on e.salary between j.lowest_salary and j.highest_salary;


-- Querey : 15.	Display the Emp name and the Manager name under whom the Employee works in the below format .

select e.ename as employee , m.ename as manager from employee as e 
join
employee as m
on m.empno = e.manager ; 
 


-- Querey : 16.	Display Empname and Total sal where Total Sal (sal + Comm)

select Ename, (salary + coalesce(commission,0)) as total_salary from employee;



-- querey : 17.	Display Empname and Sal whose empno is a odd number

select Empno ,ename, salary from employee where mod(empno,2) = 1;



-- Querey :18.	Display Empname , Rank of sal in Organisation , Rank of Sal in their department

select ename , salary ,
rank() over(order by salary desc) as sal_in_organisation,
rank() over(partition by deptno order by salary desc) as sal_in_dept
from employee
order by sal_in_organisation; 



-- Querey : 19.	Display Top 3 Empnames based on their Salary

SELECT ENAME , SALARY FROM EMPLOYEE 
ORDER BY SALARY DESC 
LIMIT 3;



-- QUEREY : Display Empname who has highest Salary in Each Department.
