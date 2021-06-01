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
-- 1) SALESMAN의 급여 최댓값
select max(sal) from emp where job = 'SALESMAN';

-- 2) sub query
select empno, ename, sal, job
from emp
where sal > (
    select max(sal) from emp where job = 'SALESMAN'
);

-- 연봉 = sal * 12 + comm
-- 연봉을 계산할 때, comm이 null인 경우에는 0으로 변환해서 계산.
-- WARD의 연봉보다 더 많은 연봉을 받는 직원들의 
-- 사번, 이름, 급여, 수당, 연봉을 출력.
-- 연봉의 내림차순 정렬해서 출력.
select empno, ename, sal, comm, 
    sal * 12 + nvl(comm, 0) as annual_sal
from emp
where sal * 12 + nvl(comm, 0) > (
    select sal * 12 + nvl(comm, 0) from emp where ename = 'WARD'
)
order by annual_sal desc;

-- 각 부서에서 급여가 가장 적은 직원들의 레코드를 검색
-- 1) 각 부서의 급여 최솟값
select min(sal) from emp group by deptno;
-- 2) 급여가 950 또는 800 또는 1300인 직원들의 레코드
select * from emp where sal in (950, 800, 1300);
-- 1), 2)의 결과를 sub query를 사용해서 합침.
select * from emp where sal in (
    select min(sal) from emp group by deptno
);

-- 10번 부서에서 급여가 1300인 직원
-- 또는, 20번 부서에서 급여가 800인 직원
-- 또는, 30번 부서에서 급여가 950인 직원
select deptno, min(sal) from emp group by deptno;
select * from emp
where (deptno, sal) in (
    select deptno, min(sal) from emp group by deptno
);

-- 각 부서에서 급여가 최댓값인 직원들의 레코드 검색.
-- 부서번호 오름차순으로 정렬 출력.
