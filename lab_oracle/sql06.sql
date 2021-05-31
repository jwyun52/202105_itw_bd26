-- 그룹 함수(여러 행 함수)
-- 컬럼의 모든 값이 입력으로 전달되서 하나의 값을 반환하는 함수
-- avg(평균), sum(합계), max, min, variance(분산), stddev(표준편차), ...

select ename from emp;
select ename, lower(ename) from emp;  -- 단일행 함수

select sal from emp;
select sum(sal), avg(sal), max(sal), min(sal), variance(sal), stddev(sal)
from emp;  -- 다중행 함수(그룹 함수)

-- 그룹함수는 단일행 함수 혹은 컬럼과 함께 select할 수 없음!
select sal from emp;  -- 14개 rows
select sum(sal) from emp;  -- 1개 row
select sal, sum(sal) from emp;  -- 에러 발생 문장

select nvl(comm, -1) from emp;  -- 14개 rows
select max(comm) from emp;  -- 1개 row
select nvl(comm, -1), max(comm) from emp;  -- 에러 발생 문장

-- 그룹 함수들은 기본적으로 null을 제외하고 기능을 수행함!
select comm from emp;  -- 4개 not null, 10개 null
select sum(comm), avg(comm) from emp;  -- 평균을 계산할 때 4로 나눔!

-- count(컬럼): 컬럼에서 null이 아닌 자료의 숫자를 반환.
select count(sal) from emp;
select count(comm) from emp;

select count(*) from emp;  -- 테이블의 전체 row의 갯수
select count(distinct deptno) from emp;  -- 구분되는(중복되지 않는) 자료의 갯수

-- 10번 부서에 근무하는 사원들의 급여 평균, 최솟값, 최댓값, 표준편차를 출력.
-- 소숫점은 2자리까지 출력
select deptno, sal from emp where deptno = 10;

select 10 as DEPTNO, 
    round(avg(sal), 2) as MEAN, 
    min(sal) as MIN, 
    max(sal) as MAX, 
    round(stddev(sal), 2) as STD_DEV
from emp
where deptno = 10;

-- 20번 부서에 근무하는 사원들의 급여 평균, 최솟값, 최댓값, 표준편차를 출력.
-- 소숫점은 2자리까지 출력
select 20 as DEPTNO, 
    round(avg(sal), 2) as MEAN, 
    min(sal) as MIN, 
    max(sal) as MAX, 
    round(stddev(sal), 2) as STD_DEV
from emp
where deptno = 20;

-- 30번 부서에 근무하는 사원들의 급여 평균, 최솟값, 최댓값, 표준편차를 출력.
-- 소숫점은 2자리까지 출력
select 30 as DEPTNO, 
    round(avg(sal), 2) as MEAN, 
    min(sal) as MIN, 
    max(sal) as MAX, 
    round(stddev(sal), 2) as STD_DEV
from emp
where deptno = 30;

-- 부서별 급여의 평균
select 10 as deptno, avg(sal) as mean from emp where deptno = 10
union
select 20 as deptno, avg(sal) as mean from emp where deptno = 20
union
select 30 as deptno, avg(sal) as mean from emp where deptno = 30;

select deptno, avg(sal)
from emp
group by deptno
order by deptno;

-- 직책(job)별 급여 평균, 최솟값, 최댓값, 직원수 출력. 
-- 소숫점은 2자리까지만 출력.
select job, round(avg(sal), 2) as AVG_SAL, 
    min(sal) as MIN_SAL, max(sal) as MAX_SAL,
    count(*) as COUNT
from emp
group by job;

