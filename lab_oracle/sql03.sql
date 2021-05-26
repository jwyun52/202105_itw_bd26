-- 테이블에서 조건을 만족하는 레코드(행) 검색
-- select 컬럼, ... from 테이블 where 조건;

-- 사원 테이블에서 10번 부서에서 일하는 사원들의 레코드를 검색
select * from emp 
where deptno = 10;

-- 사원 테이블에서 급여가 3000 이상(>=)인 사원들의 레코드를 검색
select *
from emp
where sal >= 3000;

-- 비교 연산: 
--   = (equal to), != (not equal to), > (greater than), < (less than)
--   >= (greater than or equal to), <= (less than or equal to)
-- 논리 연산: and, or, not

-- 사원 테이블에서 급여가 3000 이상 4000 이하인 사원들의 사번, 이름, 직책, 급여를 검색
select empno, ename, job, sal
from emp
where sal >= 3000 and sal <= 4000;

select empno, ename, job, sal
from emp
where sal between 3000 and 4000;

-- 사원 테이블에서 급여가 3000 이상(>=)이고, 5000 미만(<)인 사원들의 레코드 검색
select *
from emp
where sal >= 3000 and sal < 5000;

-- 위의 문장과 비교
select * 
from emp
where sal between 3000 and 5000;

-- 사원 테이블에서 급여가 1000 이하이거나 또는 5000 이상인 사원들의 레코드 검색
select *
from emp
where sal <= 1000 or sal >= 5000;
