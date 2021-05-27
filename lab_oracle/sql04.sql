-- employees 테이블의 구조 확인
desc employees;

-- employees 테이블에서 이름이 J로 시작하는 사원들의 사번, 이름을 검색
select employee_id, emp_name
from employees
where emp_name like 'J%';

-- employees 테이블에서 이름에 E 또는 e가 포함된 사원들의 사번과 이름을 검색
select employee_id, emp_name
from employees
where emp_name like '%E%' or emp_name like '%e%';

select employee_id, emp_name
from employees
where emp_name in ('%E%', '%e%');
-- where emp_name = '%E%' or emp_name = '%e%'

-- employees 테이블에서 전화번호가 011로 시작하는 사원들의 사번, 이름 전화번호를 검색
select employee_id, emp_name, phone_number
from employees
where phone_number like '011%';

-- employees 테이블에서 급여가 3000 이상 5000 이하인 사원들의 사번, 이름, 급여를 검색
select employee_id, emp_name, salary
from employees
where salary between 3000 and 5000;

select employee_id, emp_name, salary
from employees
where salary >= 3000 and salary <= 5000;

-- employees 테이블에서 수당이 있는 사원들의 사번, 이름, 급여, 1년 연봉을 검색
-- commission_pct는 수당의 퍼센티지를 의미. (수당 미포함) 1년 연봉의 몇%인지를 의미.
-- 수당 포함 연봉 = 월급 * 12 + 수당 = 월급 * 12 + (월급 * 12) * pct
--              = (월급 * 12) * (1 + pct)
select employee_id, emp_name, salary, salary * 12 * (1 + commission_pct) as 연봉
from employees
where commission_pct is not null;


-- 과제: employees 테이블에서
-- 1. 사번이 179번인 사원의 레코드를 출력
-- 2. 1에서 찾은 정보를 사용해서, 179번 사원의 직책 이름을 다른 테이블에서 검색, 출력
-- 3. 1에서 찾은 정보를 사용해서, 179번 사원이 일하는 부서의 정보를 다른 테이블에서 검색, 출력
-- 4. 1에서 찾은 정보를 사용해서, 179번 사원의 매니저 정보를 검색, 출력
-- departments 테이블에서
-- 5. manager_id가 존재하는 레코드들을 검색, 출력
-- 6. 20번 부서의 레코드를 검색, 출력
-- 7. 6에서 찾은 정보를 사용해서, 20번 부서의 관리자 정보를 다른 테이블에서 검색, 출력


