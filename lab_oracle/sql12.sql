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

-- insert 구문에서 삽입하는 컬럼 순서는 테이블 생성 시 순서를 따르지 않아도 됨.
-- 컬럼의 순서와 values에서 전달한 값들의 순서만 같으면 됨.
insert into students (sname, sid) values ('김보민', 3);

-- 테이블의 모든 컬럼에 값을 insert하는 경우에는 컬럼 이름들을 생략할 수 있음.
-- values에서는 값들의 누락 없이 테이블 생성 시 컬럼 순서대로 값을 전달하면 됨.
insert into students 
values (4, '김수빈', to_date('2021-06-03', 'YYYY-MM-DD'));

select * from students;

-- insert 구문에서 발생할 수 있는 오류들
insert into students values (5, '오쌤');  -- 에러
insert into students values (5, '오쌤', null);  -- 에러 없음
insert into students values (6, sysdate, '오쌤'); -- 에러
insert into students (sname, sid) values (6, '오쌤'); -- 에러
insert into students (sname) values ('아이티윌'); -- 에러
insert into students (sid) values (999);  -- 에러
-- 영문, 숫자, 특수문자: 1 byte
-- 한글: 2 bytes 또는 3 bytes(한글 Windows 10, Oracle 11g XE)


-- insert into ~ values ~; 구문은 행(row)을 하나씩 삽입.
-- insert into ~ select ~; 구문은 여러 행을 한번에 삽입. 테이블 내용 복사.

-- students와 같은 구조의 테이블 생성
create table students2 (
    sid number(2),
    sname varchar2(10),
    birthday date
);

-- students 테이블의 모든 행을 students2 테이블에 삽입
insert into students2
select * from students;

select * from students2;

-- TCL(Transaction Control Language): COMMIT, ROLLBACK 
commit;  -- 작업 내용(insert, update, delete 등)을 데이터베이스에 영구적으로 저장.
