SELECT ename
     , sal "인상전 급여"
     , sal + comm "총급여"
     , (sal + comm) * 1.1 as "인상된 급여(급여+보너스)"
FROM emp
WHERE sal < 3000
AND job = 'SALESMAN' -- 조건절(where) 작성.
ORDER BY ename desc;

SELECT *
FROM emp
WHERE sal > 2000
OR job = 'SALESMAN'; -- A조건 이거나 B조건.

-- 급여가 2000 ~ 3000 사이인 직원.
SELECT *
FROM emp
WHERE sal between 2000 AND 3000
--WHERE sal <= 3000
--and   sal >= 2000
;

-- 1981년도에 입사한 사원정보.
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
where ename like '_LA%'; --'%LA%'; --CLARK, CLA % => *(없거나 한글자 이상)
                                   --           _ => 한글자(에 대응)
                                   
SELECT *
FROM professor -- Primary Key (중복x)
WHERE deptno in (101, 103)
AND position like '%full%' --not in ('a full professor')-- 'a full professor'
; 

SELECT *
FROM professor -- Primary Key (중복x)
--WHERE name like '%an'
--WHERE (bonus is null and pay >= 300) -- 1) pay + bonus >= 300, 2)bonus is null, pay>=300
--   or (pay + bonus >= 300)
WHERE pay + nvl(bonus, 0) >= 300
;

SELECT *
FROM department;

SELECT *
FROM employees;

-- 교수, 학생 => 교수(학생)번호/ 이름/ 학과정보.
SELECT profno, name, deptno
FROM professor
UNION ALL -- 중복된 값 출력; UNION -- 중복된 값은 제거
SELECT studno, name, deptno1
FROM student;

-- UNION ALL(중복)
SELECT studno, name
FROM student
WHERE deptno1 = 101
MINUS
SELECT studno, name
FROM student
WHERE deptno2 = 201
order by 1;
