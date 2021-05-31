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
