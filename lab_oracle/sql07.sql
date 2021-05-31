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


-- 입사연도, 부서번호, 입사연도별 부서별 입사한 사원수 출력
-- 1980년은 제외
-- 연도별 사원수가 2명 이상인 경우만 선택
-- 연도 오름차순으로 정렬

