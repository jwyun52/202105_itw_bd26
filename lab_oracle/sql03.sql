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

-- 사원 테이블에서 부서번호가 10번이 아닌 사원들의 사번, 이름, 부서번호를 검색
select empno, ename, deptno
from emp
where deptno != 10;

select empno, ename, deptno
from emp
where not deptno = 10;

-- 사원 테이블에서 10번 또는 20번 부서에서 근무하는 사원들의 레코드를 검색
select *
from emp
where deptno = 10 or deptno = 20;

select *
from emp
where deptno in (10, 20);

-- 사원 테이블에서 10번 또는 20번 또는 30번 부서에서 근무하는 사원들의 레코드 검색
select * 
from emp
where deptno = 10 or deptno = 20 or deptno = 30;

select *
from emp
where deptno in (10, 20, 30);

-- 테이블에 저장된 값들은 대/소문자를 구분!
-- Oracle에서 문자열은 작은따옴표('')로 감싸줌.
-- 사원 테이블에서 직책이 CLERK인 사원들의 레코드 검색
select *
from emp
where job = 'CLERK';

-- CLERK이 아닌 사원들의 레코드 검색
select *
from emp
where job != 'CLERK';

-- 사원 테이블에서
-- 1) 20번 부서에서 근무하거나 또는 SALESMAN 직책을 담당하는 사원의
-- 부서번호, 사번, 이름, 직책을 검색
select deptno, empno, ename, job
from emp
where deptno = 20 or job = 'SALESMAN';

-- 2) CLERK, ANALYST, MANAGER들의 사번, 이름, 직책, 급여를 검색
select empno, ename, job, sal
from emp
where (job = 'CLERK') or (job = 'ANALYST') or (job = 'MANAGER');

select empno, ename, job, sal
from emp
where job in ('CLERK', 'ANALYST', 'MANAGER');

-- 3) CLERK, ANALYST, MANAGER가 아닌 사원들의 사번, 이름, 직책, 급여를 검색
select empno, ename, job, sal
from emp
where not ((job = 'CLERK') or (job = 'ANALYST') or (job = 'MANAGER'));

select empno, ename, job, sal
from emp
where (job != 'CLERK') and (job != 'ANALYST') and (job != 'MANAGER');

select empno, ename, job, sal
from emp
where job not in ('CLERK', 'ANALYST', 'MANAGER');

select empno, ename, job, sal
from emp
where not job in ('CLERK', 'ANALYST', 'MANAGER');

-- 문자열도 크기(대소)비교가 가능: 알파벳(사전) 순서
-- A < B < C < ... < a < b < ...
-- ㄱ < ㄴ < ㄷ < ...
select ename from emp
where ename >= 'D';

-- 날짜도 크기(대소) 비교가 가능: 연도 -> 월 -> 일 -> 시 -> 분 -> 초 순서로 비교
select * from emp;
-- 1987년 1월 1일 (포함) 이후에 입사한 사원들의 레코드
select * from emp
where hiredate >= '1987/01/01';

-- 특정 문자(열)로 시작하는 단어 검색
select ename from emp
where ename like 'A%';

select ename from emp
where ename like 'A_';

select * from emp
where job like '_LERK';

select * from emp
where job like '_ERK';

select * from emp
where job like '%ERK';

-- 사원 이름 중에 'E'가 포함된 사원들의 레코드 검색
select * from emp
where ename like '%E%';
