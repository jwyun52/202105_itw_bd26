/* SELECT 구문의 순서
select 컬럼, ...
from 테이블
where 조건
group by 컬럼, ...
having 그룹별 조건
order by 컬럼;
*/

-- emp 테이블에서 부서별 부서번호, 급여의 평균 검색, 출력
-- 부서별 급여의 평균이 2000 이상인 경우만 출력
select deptno, round(avg(sal), 1) as AVG_SAL
from emp
group by deptno
having avg(sal) >= 2000
order by deptno;

select deptno, avg(sal)
from emp
where avg(sal) >= 2000
group by deptno;  -- 에러 발생

-- emp 테이블에서 mgr가 null이 아닌 직원들 중에서
-- 부서별 급여의 평균 검색
select deptno, avg(sal)
from emp
where mgr is not null
group by deptno;

select deptno, avg(sal)
from emp
group by deptno
having mgr is not null;  -- 에러 발생

-- 직책, 직책별 사원수를 검색
-- 직책이 PRESIDENT는 제외
-- 직책별 사원수가 3명 이상인 레코드만 선택
-- 직책 이름 오름차순으로 정렬
select job, count(*)
from emp
where job != 'PRESIDENT'
group by job
having count(*) >= 3
order by job;

-- 입사연도, 부서번호, 입사연도별 부서별 입사한 사원수 출력
-- 1980년은 제외
-- 연도별 부서별 사원수가 2명 이상인 경우만 선택
-- 연도 오름차순으로 정렬
select to_char(hiredate, 'YYYY') as YEAR,
    deptno, count(*) as COUNT
from emp
where to_char(hiredate, 'YYYY') != '1980'
group by to_char(hiredate, 'YYYY'), deptno
having count(*) >= 2
order by YEAR;


-- employees 테이블에서
-- 1. 부서별 사원수, 급여의 최댓값, 최솟값, 합계, 평균, 중앙값, 분산, 표준편차 검색
-- 소숫점은 1자리까지만 출력.
-- 부서번호 오름차순 출력.
select department_id,
    count(*) as counts,
    max(salary) as max_sal,
    min(salary) as min_sal,
    sum(salary) as sum_sal,
    round(avg(salary), 1) as avg_sal,
    median(salary) as median_sal,
    round(variance(salary), 1) as var_sal,
    round(stddev(salary), 1) as std_sal
from employees
group by department_id
order by department_id;

-- 2. 직책별 사원수, 급여의 최댓값, 최솟값, 합계, 평균, 중앙값, 분산, 표준편차 검색
-- 소숫점은 1자리까지만 출력.
-- 직책 이름의 오름차순 출력.
select job_id,
    count(*) as counts,
    max(salary) as max_sal,
    min(salary) as min_sal,
    sum(salary) as sum_sal,
    round(avg(salary), 1) as avg_sal,
    median(salary) as median_sal,
    round(variance(salary), 1) as var_sal,
    round(stddev(salary), 1) as std_sal
from employees
group by job_id
order by job_id;

-- 3. 부서별 직책별 사원수 급여의 평균 검색
-- 부서번호 오름차순 -> 직책 이름 오름차순 정렬 출력.
select department_id, job_id, 
    count(*) as counts, 
    round(avg(salary), 1) as avg_sal
from employees
group by department_id, job_id
order by department_id, job_id;

-- 4. 수당을 받는 직원들의 직책별 사원수, 연봉의 평균을 직책 오름차순으로 출력
-- 연봉 = salary * 12 * (1 + commission_pct)
select job_id, 
    count(*) as counts, 
    avg(salary * 12 * (1 + commission_pct)) as avg_annual_sal
from employees
where commission_pct is not null
group by job_id;

-- 5. 부서번호가 90번이 아니고, 부서번호가 null이 아닌 사원들 중에서
-- 부서별 인원수가 10명 이상인 부서의
-- 부서별 인원수, 급여 최솟값, 최댓값을
-- 부서번호 오름차순으로 출력
select department_id, 
    count(*) as counts, 
    min(salary) as min_sal, 
    max(salary) as max_sal
from employees
where department_id != 90 and department_id is not null
group by department_id
having count(*) >= 10
order by department_id;
