-- scott 계정소유의 테이블 목록 조회.
-- Structured Query Language
select * from tab;
-- table/ column 

--테이블의 구조
desc customer;

select gno, gname, jumin, point from customer;
-- professor 테이블의 전체 목록 조회.
select * from professor;

SELECT 'hello, ' || name as "Name" -- alias(별칭)
FROM student;

SELECT name || q'['s ID: ]' || id || ' , WEIGHT is ' || weight || 'kg' 
       as "ID AND WEIGHT"
FROM student;

SELECT '''s'
FROM dual;

SELECT *
FROM department; --학과.

SELECT '부서번호는 ' || deptno || ', 이름은 ' || ename 
       as "Name with Dept"
FROM emp
order by ename; --사원.

SELECT *
FROM dept; --부서정보.

SELECT ename || '(' || job || '), ' || ename || '''' || job || '''' 
       as "NAME AND JOB"
FROM emp;
