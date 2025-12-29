select *
from tab;

select *
from employees
where 1 = 1
and salary + salary * nvl(commission_pct, 0) > 10000 -- 급여가 10000 초과하는 사람들 조회.
--where job_id = 'IT_PROG'
--where employee_id = 103
--and department_id = 50 -- shipping 부서.
--and salary <= 3000
;

select *
from jobs; -- IT_PROG

select *
from departments;

select *
from emp;
