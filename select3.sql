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





UPDATE professor
SET    hiredate = ADD_MONTHS(hiredate, -5*12)
WHERE 1 = 1;



