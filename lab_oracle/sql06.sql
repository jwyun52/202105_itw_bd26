-- 그룹 함수(여러 행 함수)
-- 컬럼의 모든 값이 입력으로 전달되서 하나의 값을 반환하는 함수
-- avg(평균), sum(합계), max, min, variance(분산), stddev(표준편차), ...

select sum(sal), avg(sal), max(sal), min(sal), variance(sal), stddev(sal)
from emp;
