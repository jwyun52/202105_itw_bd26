-- 함수(function): 입력값을 전달받아서 기능을 수행한 후 그 결과를 반환하는 것.
-- 인수(argument): 함수에 전달하는 입력값.
-- 반환값(return value): 함수가 결과로 반환해주는 값.

-- 문자열 함수: 문자열을 조작해서 새로운 문자열을 반환해 주는 함수
-- upper(arg): 입력받은 문자열(arg)를 대문자로 변환해서 반환하는 함수
-- lower(arg): 입력받은 문자열(arg)를 소문자로 변환해서 반환하는 함수
-- initcap(arg): 입력받은 문자열(arg)를 각 단어의 첫 글자만 대문자, 나머지는 소문자로 변환하는 함수

-- dual: 함수 호출 결과를 출력하기 위한 더미 테이블(dummy table)
select upper('sql developer') from dual;
select lower('SQL Developer') from dual;
select initcap('SQL DEVeloper') from dual;

-- emp 테이블에서 사원이름을 모두 소문자로 변환해서 출력
select lower(ename) from emp;

-- emp 테이블에서 Scott의 레코드를 검색
select * from emp where lower(ename) = 'scott';
select * from employees where lower(emp_name) like '%michael%';
select * from employees where lower(job_id) like 'sa%';

-- substr(문자열, 시작인덱스, 문자갯수):
-- 문자열에서 시작인덱스에서부터 문자갯수만큼 잘라낸 문자열을 반환
select substr('Hello World', 1, 5) from dual;
select substr('Hello World', 3, 6) from dual;

-- substr() 함수를 사용할 때 잘라낼 문자갯수를 전달하지 않으면, 
-- 시작인덱스부터 문자열의 끝까지를 잘라냄
select substr('https://www.google.com/', 9) from dual;

select substr('안녕하세요', 1, 2) from dual;

-- length(문자열): 문자열의 문자 갯수를 반환.
-- lengthb(문자열): 문자열이 차지하는 byte 수를 반환.
select length('hello'), lengthb('hello') from dual;
select length('안녕하세요'), lengthb('안녕하세요') from dual;

-- lpad(문자열, 자릿수, 패딩문자)
-- rpad(문자열, 자릿수, 패딩문자)
select lpad('hello', 10, '*'), rpad('hello', 10, '*') from dual;

-- emp 테이블에서 사번, 이름을 검색 출력
-- 이름은 첫 두 글자만 출력하고, '*' 3개를 패딩으로 채워서 출력
select empno, rpad(substr(ename, 1, 2), 5, '*') as name
from emp;

-- replace(문자열, before, after):
-- 문자열에 포함된 before 문자(열)을 after 문자(열)로 변환
select replace('jack and jue', 'j', 'bl') from dual;

-- 문자열에 포함된 공백들을 제거하는 용도로 replace를 사용
select replace('Hello World SQL     Dev', ' ', '') from dual;


-- 숫자 관련 함수
-- round(숫자, 소수점 자릿수): 반올림
-- trunc(숫자, 소수점 자릿수): 버림(truncate)
select round(1234.5678, 0), round(1234.5678, 1), round(1234.5678, -1)
from dual;

select trunc(1234.5678, 0), trunc(1234.5678, 1), trunc(1234.5678, -1)
from dual;

/*
사원 정보 empno, ename을 출력.
사번은 앞 두 자리만 보여주고 나머지는 *로 출력
이름은 첫 글자만 보여주고 나머지는 *로 출력
(결과 예시)
empno mask_no ename mask_name
-----------------------------
 7369    73** SMITH S****
*/
select empno, 
    rpad(substr(empno, 1, 2), 4, '*') as mask_no,
    ename,
    rpad(substr(ename, 1, 1), length(ename), '*') as mask_name
from emp;

/*
사원들의 월 평균 근무일수는 21.5일이고, 하루 근무 시간을 8시간이라고 할 때,
사원들의 일 급여(day_pay), 시급(time_pay)를 계산하여 출력.
일 급여는 소숫점 세번째 자리에서 버림, 시급은 소숫점 두번째 자리에서 반올림
(결과 예시)
empno ename sal day_pay time_pay
--------------------------------
 7369 SMITH 800   37.20      4.7
*/
select empno, ename, sal,
    trunc(sal / 21.5, 2) as day_pay,
    round(sal / (21.5 * 8), 1) as time_pay
from emp;


-- 날짜 관련 함수
select sysdate from dual;
select add_months(sysdate, 1) from dual;

-- emp 테이블에서 사번, 이름, 입사일, 입사 후 3달이 되는 시점을 출력
select empno, ename, hiredate, 
    add_months(hiredate, 3) as hire_3
from emp;

select hiredate, months_between(hiredate, sysdate) from emp;
select hiredate, 
    trunc(months_between(sysdate, hiredate))
from emp;

select hiredate, round(hiredate, 'YYYY'), trunc(hiredate, 'YYYY')
from emp;

select hiredate, round(hiredate, 'MM'), trunc(hiredate, 'MM')
from emp;

-- 타입 변환 함수: to_char, to_number, to_date
select to_number('15,000', '999,999') from dual;
select to_number('15,000,000', '00,000,000') as "number" from dual;
select to_number('1,000.15', '999,999.999' ) from dual;
select to_number('1,000.15', '0,000.000' ) from dual;

-- 날짜 -> 문자열
select sysdate,
    to_char(sysdate, 'YYYY-MM-DD'),
    to_char(sysdate, 'MM/DD/YYYY'),
    to_char(sysdate, 'DD/MM/YYYY'),
    to_char(sysdate, 'DAY')
from dual;

-- 문자열 -> 날짜
select to_date('2021-05-28', 'YYYY-MM-DD'),
    to_date('05-28-21', 'MM-DD-YY')
from dual;

-- emp 테이블에서 1987년 1월 1일 (포함) 이후에 입사한 사원들의 레코드 출력
select * from emp
where hiredate >= to_date('1987-01-01', 'YYYY-MM-DD');


-- null 값 대체 함수:
-- nvl(컬럼, null 대체 값)
-- nvl2(컬럼, null이 아닐 때 대체할 값, null일 때 대체할 값)
select comm, nvl(comm, 0), nvl2(comm, 'TRUE', 'FALSE')
from emp;

-- nvl2함수를 사용해서 nvl 함수와 같은 결과를 만들려면?
select comm, nvl2(comm, comm, 0)
from emp;

-- emp 테이블에서 사번, 이름, 급여, 수당, 연봉(comm 포함)을 출력
select empno, ename, sal, comm, 
    sal * 12 + nvl(comm, 0) as annual_sal
from emp;

select empno, ename, sal, comm,
    nvl2(sal * 12 + comm, sal * 12 + comm, sal * 12) as annual_sal
from emp;

-- emp 테이블에서 연봉(comm 포함)이 30,000 이상인 사원들의 사번, 이름, 급여, 수당, 연봉
select empno, ename, sal, comm, 
    sal * 12 + nvl(comm, 0) as annual_sal
from emp
where sal * 12 + nvl(comm, 0) >= 30000;

-- comm이 null인 경우 null이 아닌 comm의 평균값으로 대체
select avg(comm) from emp;  -- avg 함수는 null 값들을 제외하고 평균을 계산해줌.
select nvl2(comm, comm, 550) from emp;
select nvl2(comm, comm, avg(comm)) from emp;  -- 에러 발생 문장
-- 단일행 함수와 그룹함수(다중행 함수)는 함께 사용할 수 없음.
select nvl2(comm, comm, 
            (select avg(comm) from emp))
from emp;