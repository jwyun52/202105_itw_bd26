-- SQL 워크시트 생성(Alt+F10): 새 워크시트(접속) 생성

-- CSV(Comma-Separated Values) 파일: 
--  테이블의 값들이 comma로 구분된 형식의 텍스트 파일.
--  comma로 값을 구분하는 경우가 일반적이지만, tab이나 colon(:) 등을 구분자로 사용하기도 함.

-- 테이블 구조 확인
-- desc 테이블이름;
desc dept;
desc emp;
desc salgrade;

-- SQL 명령어(키워드)는 대/소문자를 구분하지 않음.
-- Oracle 데이터베이스 시스템은 테이블 이름과 컬럼 이름을 대문자로 변환 관리.

-- Oracle의 데이터 타입(유형)
--  (1) number: 숫자 타입(정수, 실수)
--  (2) varchar2: variable-length characters. 가변길이 문자열.
--  (3) date: 날짜/시간.

-- 테이블에서 데이터를 검색
--  (1) projection: 테이블에서 원하는 컬럼을 검색
--  (2) selection: 테이블에서 조건을 만족하는 레코드(행)을 검색

-- select 컬럼1, 컬럼2, ... from 테이블이름;
-- 사원 테이블에서 사번, 사원 이름을 검색
select empno, ename from emp;

-- 사원 테이블에서 사번, 이름, 입사날짜, 급여를 검색
select empno, ename, hiredate, sal from emp;
select empno, ename, sal, hiredate from emp;

-- 테이블에서 모든 컬럼(모든 자료)를 검색
select * from emp;

-- select할 때 컬럼 이름의 별명(alias)을 작성
-- select 컬럼이름 as 별명, ... from 테이블이름;
select empno as 사번, ename as 이름 
from emp;

-- 사원 테이블에서 사번, 이름, 급여, 연봉(sal * 12)을 검색
select empno, ename, sal, sal * 12 as annual_sal
from emp;

-- 사원 테이블에서 직책 검색
select job from emp;

-- 컬럼에서 중복되지 않는 값들만 검색
select distinct job from emp;

-- distinct는 select 문에서 한번만, 모든 컬럼들의 이름 앞에 사용!
select distinct job, deptno
from emp;

-- select job, distinct deptno fro emp;  -- 오류(error) 발생 문장
