-- DDL(Data Definition Language): CREATE, ALTER, DROP, TRUNCATE

/*  테이블 생성
create table 테이블이름 (
    컬럼이름 데이터타입,
    ...
);
*/

-- 테이블 이름: students
-- 컬럼 이름/데이터 타입
-- (1) sid: 학생 아이디, 숫자(number) 2자리 
-- (2) sname: 학생 이름, 문자열(varchar2) 10 bytes
-- (3) birthday: 학생 생일, 날짜(date)
create table students (
    sid number(2),
    sname varchar2(10),
    birthday date
);

-- students 테이블의 구조 확인(컬럼, NULL 여부, 데이터 타입)
desc students;

-- DQL(Data Query Language): SELECT
select * from students;

-- DML(Data Manipulation Language): INSERT, UPDATE, DELETE

/* INSERT: 테이블에 레코드(행) 추가
insert into 테이블이름 (컬럼1, 컬럼2, ...) values (값1, 값2, ...);
*/
insert into students (sid, sname) values (1, '곽기현');
select * from students;

insert into students (sid, sname, birthday)
values (2, '김도연', to_date('2021-06-04', 'YYYY-MM-DD'));
