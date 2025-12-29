SELECT ename
     , sal "�λ��� �޿�"
     , sal + comm "�ѱ޿�"
     , (sal + comm) * 1.1 as "�λ�� �޿�(�޿�+���ʽ�)"
FROM emp
WHERE sal < 3000
AND job = 'SALESMAN' -- ������(where) �ۼ�.
ORDER BY ename desc;

SELECT *
FROM emp
WHERE sal > 2000
OR job = 'SALESMAN'; -- A���� �̰ų� B����.

-- �޿��� 2000 ~ 3000 ������ ����.
SELECT *
FROM emp
WHERE sal between 2000 AND 3000
--WHERE sal <= 3000
--and   sal >= 2000
;

-- 1981�⵵�� �Ի��� �������.
SELECT *
FROM emp
WHERE hiredate between '81/01/01' and '81/12/31'
ORDER BY hiredate;

-- in (a,b,c)
SELECT *
FROM emp
WHERE deptno in (10, 20)
AND ename not in ('SMITH', 'FORD'); -- deptno >= 10 and deptno <= 20;

-- is null / is not null
SELECT *
FROM emp
WHERE comm is null; -- ''

-- like ( = )
SELECT *
from EMP
where ename like '_LA%'; --'%LA%'; --CLARK, CLA % => *(���ų� �ѱ��� �̻�)
                                   --           _ => �ѱ���(�� ����)
                                   
SELECT *
FROM professor -- Primary Key (�ߺ�x)
WHERE deptno in (101, 103)
AND position like '%full%' --not in ('a full professor')-- 'a full professor'
; 

SELECT *
FROM professor -- Primary Key (�ߺ�x)
--WHERE name like '%an'
--WHERE (bonus is null and pay >= 300) -- 1) pay + bonus >= 300, 2)bonus is null, pay>=300
--   or (pay + bonus >= 300)
WHERE pay + nvl(bonus, 0) >= 300
;

SELECT *
FROM department;

SELECT *
FROM employees;

-- ����, �л� => ����(�л�)��ȣ/ �̸�/ �а�����.
SELECT profno, name, deptno
FROM professor
UNION ALL -- �ߺ��� �� ���; UNION -- �ߺ��� ���� ����
SELECT studno, name, deptno1
FROM student;

-- UNION ALL(�ߺ�)
SELECT studno, name
FROM student
WHERE deptno1 = 101
MINUS
SELECT studno, name
FROM student
WHERE deptno2 = 201
order by 1;

----------- 12.29 todo. --------------
select ename || '''s sal is $' || sal 
from emp;
--------------------------------------

