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
