/******************************
1. Oracle 11g XE(Express Edition)의 연습 계정 활성화
  (1) 명령 프롬프트 실행
  (2) 오라클 DBA 계정으로 접속
      C:\User\STU> sqlplus SYSTEM/oracle as sysdba
  (3) 잠겨 있는 hr 계정을 해제(unlock)
      SQL> alter user hr identified by hr account unlock;
  (4) hr 계정으로 접속
      SQL> connect hr/hr
  (5) sqlplus 종료
      SQL> exit
  (6) 명령 프롬프트 종료
  
2. SQL Developer에서 "새 접속" 만들기
  (1) Name: hr
  (2) 사용자 이름: hr
  (3) 비밀번호: hr
  (4) 비밀번호 저장 체크
  (5) 테스트 버튼 클릭 -> 상태(성공) 확인
  (6) 저장 버튼 클릭
  (7) 접속 버튼 클릭
******************************/

-- HR 계정의 테이블들을 사용한 GROUP BY, JOIN, SUB QUERY 연습

-- 1. 직원의 이름과 성(first/last name), 부서 이름을 검색.
select distinct department_id from employees;

select e.first_name || ' ' || e.last_name as name,
    d.department_name
from employees e join departments d
    on e.department_id = d.department_id;

select e.first_name || ' ' || e.last_name as name,
    d.department_name
from employees e, departments d
where e.department_id = d.department_id;
    
-- 2. 직원의 이름과 성, 부서 이름을 검색. 부서번호가 없는 직원도 출력.
select e.first_name || ' ' || e.last_name as name,
    d.department_name
from employees e left join departments d
    on e.department_id = d.department_id;

select e.first_name || ' ' || e.last_name as name,
    d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);
    
-- 3. 직원의 이름과 직책 이름(job title)을 검색.
select distinct job_id from employees;

select e.first_name || ' ' || e.last_name as name,
    j.job_title
from employees e join jobs j
    on e.job_id = j.job_id;

select e.first_name || ' ' || e.last_name as name,
    j.job_title
from employees e, jobs j
where e.job_id = j.job_id;
    
-- 4. 직원의 이름과 그 직원이 근무하는 도시 이름(city)을 검색.
select e.first_name, l.city
from employees e 
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id;

select e.first_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id 
    and d.location_id = l.location_id;

-- 5. 직원의 이름과 그 직원이 근무하는 도시 이름(city)을 검색.
-- 근무하는 도시 이름을 알 수 없는 직원도 출력.
select e.first_name, l.city
from employees e
    left join departments d on e.department_id = d.department_id
    left join locations l on d.location_id = l.location_id;

select e.first_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+) 
    and d.location_id = l.location_id(+);
    
-- 6. 2008년에 입사한 직원들의 이름을 검색.
select max(hire_date), min(hire_date) from employees;

select first_name
from  employees
where to_char(hire_date, 'YYYY') = '2008';

-- 7. 2008년에 입사한 직원들의 부서이름, 부서별 인원수 검색.
select d.department_name, count(e.employee_id)
from employees e join departments d 
    on e.department_id = d.department_id
where to_char(e.hire_date, 'YYYY') = '2008'
group by d.department_name;

select d.department_name, count(e.employee_id)
from employees e, departments d 
where to_char(e.hire_date, 'YYYY') = '2008'
    and e.department_id = d.department_id
group by d.department_name;

-- 8. 2008년에 입사한 직원들의 부서이름, 부서별 인원수 검색.
-- 단, 부서별 인원수가 5명 이상인 경우만 출력.
select d.department_name, count(e.employee_id)
from employees e join departments d 
    on e.department_id = d.department_id
where to_char(e.hire_date, 'YYYY') = '2008'
group by d.department_name
having count(e.employee_id) >= 5;

select d.department_name, count(e.employee_id)
from employees e, departments d 
where to_char(e.hire_date, 'YYYY') = '2008'
    and e.department_id = d.department_id
group by d.department_name
having count(e.employee_id) >= 5;

-- 9. 부서번호, 부서별 급여 평균을 검색. 소숫점 한자리까지 반올림 출력.
select department_id, round(avg(salary), 1) as avg_sal
from employees
group by department_id
order by department_id;

-- 10. 부서별 급여 평균이 최대인 부서의 부서번호, 급여 평균을 검색.
-- 1) 부서별 급여 평균의 최댓값
select max(avg(salary)) from employees group by department_id;

-- 2)
select department_id, round(avg(salary), 1) as avg_sal
from employees
group by department_id
having avg(salary) = (
    select max(avg(salary)) from employees 
    group by department_id
);

-- 3) 위 결과에서 부서번호 대신 부서이름 출력
select d.department_name, round(avg(e.salary), 1) as avg_sal
from employees e join departments d
    on e.department_id = d.department_id
group by d.department_name
having avg(salary) = (
    select max(avg(salary)) from employees 
    group by department_id
);

select d.department_name, round(avg(e.salary), 1) as avg_sal
from employees e, departments d
where e.department_id = d.department_id
group by d.department_name
having avg(salary) = (
    select max(avg(salary)) from employees 
    group by department_id
);

-- 11. 사번, 직원이름, 국가이름, 급여 검색
select e.employee_id, e.first_name, c.country_name, e.salary
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id;

select e.employee_id, e.first_name, c.country_name, e.salary
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id
    and d.location_id = l.location_id
    and l.country_id = c.country_id;

-- 12. 국가이름, 국가별 급여 합계 검색
select c.country_name, sum(e.salary)
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
group by c.country_name;

select c.country_name, sum(e.salary)
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id
    and d.location_id = l.location_id
    and l.country_id = c.country_id
group by c.country_name;

-- 13. 사번, 직원이름, 직책이름, 급여를 검색.
select e.employee_id, e.first_name, j.job_title, e.salary
from employees e
    join jobs j on e.job_id = j.job_id;

select e.employee_id, e.first_name, j.job_title, e.salary
from employees e, jobs j 
where e.job_id = j.job_id;
    
-- 14. 직책이름, 직책별 급여 평균, 최솟값, 최댓값 검색.
select j.job_title, avg(e.salary), min(e.salary), max(e.salary), count(e.employee_id)
from employees e join jobs j on e.job_id = j.job_id
group by j.job_title;

select j.job_title, avg(e.salary), min(e.salary), max(e.salary), count(e.employee_id)
from employees e, jobs j 
where e.job_id = j.job_id
group by j.job_title;

-- 15. 국가이름, 직책이름, 국가별 직책별 급여 평균 검색.
select c.country_name, j.job_title, round(avg(e.salary), 1)
from employees e
    join jobs j on e.job_id = j.job_id
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
group by c.country_name, j.job_title
order by c.country_name, j.job_title;

select c.country_name, j.job_title, round(avg(e.salary), 1)
from employees e, jobs j, departments d, locations l, countries c
where e.job_id = j.job_id
  and e.department_id = d.department_id
  and d.location_id = l.location_id
  and l.country_id = c.country_id
group by c.country_name, j.job_title
order by c.country_name, j.job_title;

-- 16. 국가이름, 직책이름, 국가별 직책별 급여 합계을 출력.
-- 미국에서, 국가별 직책별 급여 합계가 50,000 이상인 레코드만 출력.
select c.country_name, j.job_title, sum(e.salary)
from employees e
    join jobs j on e.job_id = j.job_id
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
group by c.country_name, j.job_title
having c.country_name = 'United States of America'
    and sum(e.salary) >= 50000;

select c.country_name, j.job_title, sum(e.salary)
from employees e
    join jobs j on e.job_id = j.job_id
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
where c.country_id = 'US'
group by c.country_name, j.job_title
having sum(e.salary) >= 50000;

select c.country_name, j.job_title, sum(e.salary)
from employees e, jobs j, departments d, locations l, countries c
where e.job_id = j.job_id
  and e.department_id = d.department_id
  and d.location_id = l.location_id
  and l.country_id = c.country_id
  and c.country_id = 'US'
group by c.country_name, j.job_title
having sum(e.salary) >= 50000;