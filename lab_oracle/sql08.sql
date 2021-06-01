-- Sub Query

-- emp 테이블에서, 전체 직원의 급여의 평균보다 더 많은 급여를 받는 직원들의 레코드를  검색 
-- 1) 전체 직원의 급여 평균
select avg(sal) from emp;
-- 2) 평균보다 급여를 더 많이 받는 직원
select * from emp
where sal > 2073;

select * from emp
where sal > (
    select avg(sal) from emp
);

-- emp 테이블에서, ALLEN보다 적은 급여를 받는 직원들의 사번, 이름, 급여를 출력
-- 1) allen의 sal
select sal from emp where ename = 'ALLEN';

-- 2) sub query
select empno, ename, sal
from emp
where sal < (
    select sal from emp where ename = 'ALLEN'
);

-- emp 테이블에서, ALLEN과 같은 직책의 직원들의 사번, 이름, 부서번호, 직책, 급여를 출력
-- 1) allen의 job
select job from emp where ename = 'ALLEN';

-- 2) sub query
select empno, ename, deptno, job, sal
from emp
where job = (
    select job from emp where ename = 'ALLEN'
);

--  SALESMAN의 급여 최댓값보다 더 많은 급여를 받는 직원들의 사번, 이름, 급여, 직책을 출력

