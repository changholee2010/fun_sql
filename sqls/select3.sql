SELECT * FROM tab;

SELECT empno
      ,ename
      ,sal
      ,nvl(comm, 0) AS commission
FROM emp;

SELECT initcap(POSITION) AS "InitCap"
      ,lower(upper(position)) AS "Uppercase->Lowercase"
      ,length(position) length_position -- 문자의 크기 반환.
      ,lengthb('홍길동') lengthb -- byte의 크기를 반환.
      ,POSITION
      ,name
FROM professor
WHERE LENGTH(name) < 10;

SELECT ename || ',' || job AS "Name And Job"
      ,concat(concat(ename, ','), job) AS "Name Job"
      ,substr(e.job, 1, 3) AS "short Job"
      ,e.*
FROM emp e
WHERE substr(e.ename, 1, 1) = 'J';

SELECT substr('abcde', 3, 3) -- (abcde, 시작위치, 크기)
      ,substr('hello, world', -3, 3)
FROM dual;

-- 전공1(201) 연락처에(TEL컬럼) ')'
SELECT name 
--      ,instr(tel, ')', 1) "location of )"
      ,tel
      ,substr(tel, 1, instr(tel, ')', 1) - 1) AS "AREA CODE"
      ,instr(tel, ')', 1) + 1 AS "from"
      ,instr(tel, '-', 1) AS "to"
      ,substr(tel, instr(tel, ')', 1) + 1, 
                   (instr(tel, '-', 1) - (instr(tel, ')', 1) + 1))) AS "국번"
FROM student
WHERE deptno1 = 201
AND substr(tel, 1, instr(tel, ')', 1) - 1) = '02';

-- lpad(컬럼, 자리수, 채울값)
SELECT lpad('abc', 5, '-')
FROM dual;

SELECT studno
      ,name
      ,id
      ,lpad(id, 10, '*') "lpad with *"
FROM student
WHERE deptno1 = 201;

SELECT lpad(ename, 9, '12345678') lpad
      ,rpad(ename, 9, '-') rpad
      ,rpad(ename, 9, substr('123456789', LENGTH(ename)+1)) rpad2
      ,substr('123456789', LENGTH(ename)+1) AS "rep"
FROM emp
WHERE deptno = 10;

SELECT ltrim('abcde', 'abc')
      ,rtrim('abcde', 'cde')
      ,rtrim(ltrim(' hello ', ' '), ' ') -- 'hello'
      ,replace(' hello ', ' ', '*') -- 'hello'
FROM dual;

SELECT REPLACE(e.ename, substr(e.ename, 1, 2), '**') "rep"
      ,replace(e.ename, substr(e.ename, 2, 2), '--') "rep2"
      , e.job
      ,e.*
FROM emp e
WHERE deptno = 10;

SELECT name
      ,tel
      ,REPLACE(tel -- 대상컬럼.
              ,substr(tel -- 대상컬럼.
                     ,instr(tel, ')', 1) + 1 -- 시작위치
                     ,instr(tel, '-', 1) - instr(tel, ')', 1) - 1) -- 크기
              ,substr('****'
                     , 1
                     , instr(tel, '-', 1) - instr(tel, ')', 1) - 1) ) replacea
FROM student
WHERE deptno1 = 201;

-- 숫자함수.
SELECT round(12.345, 1) -- 12.3
      ,round(12.345, 2) -- 12.35
      ,round(12.345, 3) -- 12.345
      ,round(12.345, -1)-- 10
      ,trunc(12.345, 2) -- 12.34
      ,mod(12, 5)       -- 2 (나머지)
      ,ceil(12/5)       -- 3< 2.4 <2
      ,floor(12/5)      -- 2
      ,power(3, 3)      -- 3 * 3 * 3 => 27
FROM dual;

-- 날짜.
SELECT ename
      ,hiredate
      --,hiredate + 1
      ,sysdate -- 현재날짜, 시간
      --,months_between(sysdate, hiredate) "MonthBetween" -- 두 시간 사이에 몇달 차.
      --,ADD_MONTHS(sysdate, -1) -- 월정보 추가.
      --,next_day(sysdate-7, '수') -- 다음 요일의 날짜()
      --,last_day(add_months(sysdate, -1)) -- 달의 마지막날
      ,round(sysdate - (3/24))  -- 12/30 12시 이후 => 12/31
      ,trunc(sysdate, 'mm') -- 2025/12/30
FROM emp;

SELECT *
FROM professor
WHERE hiredate < sysdate; -- 2025, 1982

-- 교수번호(profno), 이름(name), 급여(pay), 보너스(bonus)
-- 근무년수 20년 넘는 교수. + 근무년수(25년)
-- 근무년수가 10년 이상 20년 미만인 교수의 "15년 3개월"
SELECT profno
     , name
     , pay || '만원' "PAY"
     , bonus || '만원' "BONUS"
     , trunc(MONTHS_BETWEEN(sysdate, hiredate) / 12)||'년' "근무년수"
FROM professor
WHERE MONTHS_BETWEEN(sysdate, hiredate) >= 20 * 12;

SELECT profno
     , name
     , pay
     , bonus
     , hiredate
     , trunc(MONTHS_BETWEEN(sysdate, hiredate) / 12) || '년' ||
      mod(trunc(MONTHS_BETWEEN(sysdate, hiredate)) , 12) || '개월' AS "근무년수"
FROM professor
WHERE MONTHS_BETWEEN(sysdate, hiredate) >= 10 * 12
AND   MONTHS_BETWEEN(sysdate, hiredate) < 20 * 12
ORDER BY hiredate;

SELECT 2 + '2' "묵시적 형변환"
      ,2 + to_number('2') "명시적 형변환"
FROM dual;

SELECT sysdate -- date 값.
      ,to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') today-- varchar2 값.
      ,to_char(123456789.12, '00,999,999,999.99') num -- varchar2 값.
      ,to_date('2024-05-06 10:10:10', 'YYYY-MM-DD HH:MI:SS') str -- date 값.
FROM dual
WHERE to_date('2025-12-31', 'YYYY-MM-DD') < sysdate + 1;

-- nvl()
SELECT nvl('hello', '0')
FROM dual;

SELECT ename 
      ,sal + nvl(comm, 0) AS "총급여"
      ,sal + nvl2(comm, comm, 0) AS "전체급여"
      ,nvl2(comm, sal + comm, sal) AS "토탈급여"
      ,sal + comm AS "급여"
FROM emp;

-- decode() 함수.
SELECT decode(null, 'null', '같다', '다르다')
FROM dual;

SELECT deptno1
      ,decode(deptno1, 101, 'Computer Eng.',
                       102, 'Multimedia Eng.',
                       103, 'Software Eng.', 'ETC') AS "decode1" 
      ,decode(deptno1, 101, 'Computer Eng.', 
                    decode(deptno1, 102, 'Multi Eng.', 
                            decode(deptno1, 103, 'Software Eng.', 'ETC'))) AS "decode2"
FROM student;

/*
101	Computer Engineering
102	Multimedia Engineering
103	Software Engineering
그외 기타
*/
SELECT * FROM department;

SELECT * FROM tab;

-- 이름,주민번호...
SELECT name 
      ,jumin
      ,decode(substr(jumin, 7, 1), 1, 'Man', 2, 'Woman') "Gender"
      -- case when then ... end 구문으로 변경.
      ,CASE substr(jumin, 7, 1) WHEN '1' THEN 'Man'
                                WHEN '2' THEN 'Woman'
       END "Gender2"
FROM student
WHERE deptno1 = 101;

SELECT name 
      ,tel
      ,decode(substr(tel, 1, instr(tel, ')', 1) - 1) -- 판별할 값.
             ,'02', 'SEOUL'
             ,'031', 'GYEONGGI'
             ,'051', 'BUSAN'
             ,'052', 'ULSAN'
             ,'055', 'GYEONGNAM'
             ,'ETC') loc
      -- case 컬럼 when 조건1 then 출력1     구문.
      ,CASE substr(tel, 1, instr(tel, ')', 1) - 1) WHEN '02' THEN 'SEOUL'
                                                   WHEN '031' THEN 'GYEONGGI'
                                                   WHEN '051' THEN 'BUSAN'
                                                   WHEN '052' THEN 'ULSAN'
                                                   WHEN '055' THEN 'GYEONGNAM'
                                                   ELSE 'ETC'
       END loc2
FROM student
--WHERE deptno1 = 101
;

-- case 구문을 활용 조건의 범위를 지정.
-- 01 ~ 03 => 1/4,  04 ~ 06 => 2/4, ... 10 ~ 12 => 4/4
SELECT name
      ,substr(jumin, 3, 2) "MONTH"
      ,CASE WHEN substr(jumin, 3, 2) BETWEEN '01' AND '03' THEN '1/4'
            WHEN substr(jumin, 3, 2) BETWEEN '04' AND '06' THEN '2/4'
            WHEN substr(jumin, 3, 2) BETWEEN '07' AND '09' THEN '3/4'
            WHEN substr(jumin, 3, 2) BETWEEN '10' AND '12' THEN '4/4'
       END "Quater"
FROM student;

-- case 퀴즈.
SELECT empno
      ,ename
      ,sal
      ,CASE WHEN sal BETWEEN 1 AND 1000 THEN 'Level 1'
            WHEN sal BETWEEN 1001 AND 2000 THEN 'Level 2'
            WHEN sal BETWEEN 2001 AND 3000 THEN 'Level 3'
            WHEN sal BETWEEN 3001 AND 4000 THEN 'Level 4'
            ELSE 'Level 5'
       END "LEVEL"
FROM emp
ORDER BY sal desc;

-- group 함수.
SELECT deptno, ename, count(*) "인원", sum(sal) "부서별 급여"
FROM emp
GROUP BY deptno, ename; -- 부서번호별 그룹.

-- emp 테이블.
SELECT * FROM emp;
SELECT deptno, job
      ,count(1) "건수"
      ,sum(sal + nvl(comm, 0)) "직무별 급여합계"
      ,round(sum(sal + nvl(comm, 0)) / count(1)) "직무별 평균급여"
      ,round(avg(sal + nvl(comm, 0)))  "직무별 평균급여1"
      ,min(sal + nvl(comm, 0)) "최저급여"
      ,max(sal + nvl(comm, 0)) "최고급여"
      --,stddev(sal) "표준편차"
      --,variance(sal) "분산"
FROM emp
GROUP BY deptno, job; -- 부서, 직무 

-- 직무별 그룹.
SELECT job
      ,sum(sal)
      ,round(avg(sal)) "직무별 평균급여"
FROM emp
--WHERE sal > 1500                 -- where 절 조건문.
GROUP BY job
--HAVING round(avg(sal)) > 1500; -- having 절 조건문.
UNION ALL
SELECT '전체'
      ,sum(sal)
      ,round(avg(sal))
FROM emp;

-- 부서/ 직무(업)/ 정보조회(평균급여, 사원수).
-- 1.부서별 직무별 평균급여, 사원수.
SELECT deptno||'', job, avg(sal), count(1)
FROM emp
GROUP BY deptno, job
-- 2.부서별 평균급여, 사원부.
UNION all
SELECT deptno||'', '소계', round(avg(sal)), count(1)
FROM emp 
GROUP BY deptno
-- 3.전체 평균급여, 사원수.
UNION ALL
SELECT '전체', '', round(avg(sal)), count(1)
FROM emp
ORDER BY 1, 2;

-- rollup 함수.
SELECT nvl(deptno || '', '전체') dept
      ,decode(deptno, NULL, ' ', nvl(job, '소계')) job
      ,round(avg(sal)) avg_sal
      ,count(1) cnt_emp
      --,nvl(deptno, 1) order_by
FROM emp
GROUP BY rollup(deptno, job)
ORDER BY nvl(deptno, 1), 1, 2;

-- emp, dept 테이블.
SELECT empno, ename, e.deptno, dname, loc, d.deptno
FROM emp e -- driving 테이블.
join dept d ON e.deptno = d.deptno -- 조인 기준.
WHERE dname = 'ACCOUNTING'; -- ANSI 조인.

SELECT empno, ename, e.deptno, dname, loc, d.deptno
FROM emp e -- driving 테이블.
    ,dept d
WHERE e.deptno = d.deptno
AND   dname = 'ACCOUNTING'; -- ORACLE 조인.

SELECT *
FROM dept;

-- 학생, 교수, 학과 조인결과.
-- 학번, 이름, 담당교수이름, 학과명.
SELECT s.studno "학번"
      ,s.name "학생이름"
      ,p.name "교수이름"
      ,d.dname "학과명"
FROM student s
JOIN professor p ON s.profno = p.profno -- 학생 - 교수 테이블의 조인조건.
JOIN department d ON s.deptno1 = d.deptno -- 학생 - 학과 테이블 조인.
; -- 등가조인(equi join)

-- 고객테이블()
SELECT c.*, g.gname
FROM customer c
JOIN gift g ON c.point >= g.g_start AND c.point <= g.g_end
--JOIN gift g ON c.point BETWEEN g.g_start AND g.g_end
; -- 비등가조인(non-equi join)

-- 학생, 학점
SELECT s.studno "학번"
      ,s.name "학생이름"
      ,c.total "점수"
      ,h.grade
FROM student s
JOIN score c ON s.studno = c.studno
JOIN hakjum h ON c.total >= h.min_point AND c.total <= h.max_point;

-- 문제2.
SELECT name
      ,e.POSITION
      ,pay
      ,s_pay "Low PAY"
      ,e_pay "High Pay"
FROM emp2 e
JOIN p_grade p ON e.POSITION = p.position;

-- 문제3.
SELECT name
      ,trunc(MONTHS_BETWEEN(sysdate, birthday) / 12) "AGE"
      ,e.POSITION curr_position
      ,p.POSITION be_position
FROM emp2 e
JOIN p_grade p 
ON trunc(MONTHS_BETWEEN(sysdate, birthday) / 12) BETWEEN p.s_age AND p.e_age;

-- 아우터조인(outer join) vs inner join
SELECT s.studno "학번"
      ,s.name "학생이름"
      ,p.profno "교수번호"
      ,p.name "교수이름"
FROM student s
JOIN professor p ON s.profno = p.profno;
-- self join
SELECT e1.empno "사원번호"
      ,e1.ename "사원이름"
      ,e2.empno "관리자번호"
      ,e2.ename "관리자이름"
FROM emp e1
LEFT OUTER JOIN emp e2 ON e1.mgr = e2.empno;

-- 문제4)










