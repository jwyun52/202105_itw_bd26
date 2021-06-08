-- DDL: create, drop, truncate, alter

-- drop: 테이블의 모든 레코드를 삭제하고, 테이블도 삭제
-- truncate: 테이블의 모든 레코드를 삭제.
-- delete: 테이블의 레코드를 삭제. (DDL이 아니라 DML)

create table test1 (
    tid number(2)
);

insert into test1 values(1);
insert into test1 values(2);
insert into test1 values(10);

select * from test1;

delete from test1;

truncate table test1;

drop table test1;


create table ex_10 (
    id      number(4) primary key,
    pw      varchar2(20) not null
);

-- alter table 테이블이름 변경내용;

-- 이름 변경(rename): (1) 테이블 이름 변경, (2) 컬럼 이름 변경, (3) 제약조건 이름 변경
-- (1) 테이블 이름 변경: 
-- alter table 테이블이름 rename to 새로운 테이블 이름;
alter table ex_10 rename to ex_users;

-- (2) 컬럼 이름 변경:
-- alter table 테이블이름 rename column 변경전 이름 to 변경후 이름;
-- id -> user_id
alter table ex_users 
rename column id to user_id;

-- pw -> user_pw
alter table ex_users
rename column pw to user_pw;

-- (3) 제약조건 이름 변경
-- alter table 테이블이름 rename constraint 변경전 이름 to 변경 후 이름;
desc user_constraints;
select constraint_name, constraint_type
from user_constraints
where table_name = 'EX_USERS';

-- SYS_C007111 -> pk_users
alter table ex_users 
rename constraint SYS_C007111 to pk_users;

-- SYS_C007110 -> nn_user_pw
alter table ex_users
rename constraint SYS_C007110 to nn_user_pw;


-- 추가(add): (1) 컬럼, (2) 제약조건
-- (1) alter table 테이블이름 add 컬럼이름 데이터타입 [기본값 제약조건];
-- (2) alter table 테이블이름 add constraint 제약조건이름 제약조건 내용;
-- ex_users 테이블에 user_email 컬럼 추가. 데이터 타입은 100 byte 문자열.
alter table ex_users
add user_email varchar2(100);

-- ex_users 테이블의 user_email 컬럼에 not null 제약조건 추가
alter table ex_users
add constraint nn_user_email check (USER_EMAIL is not null);
-- add constraint에서 제약조건 이름은 생략할 수 없음.


-- 삭제(drop): (1) 컬럼, (2) 제약조건
-- (1) alter table 테이블이름 drop column 컬럼이름;
-- (2) alter table 테이블이름 drop constraint 제약조건이름;

select constraint_name from user_constraints where table_name = 'EX_USERS';

-- nn_user_email 제약조건 삭제
alter table ex_users drop constraint nn_user_email;

-- user_email 컬럼 삭제
alter table ex_users drop column user_email;

desc ex_users;


-- 수정(modify): 컬럼의 내용(데이터 타입, null 가능 컬럼->not null 컬럼)
-- alter table 테이블이름 modify 컬럼이름 변경내용;
-- ex_users 테이블의 user_pw 컬럼의 데이터 타입을 100 byte 문자열로 변경
alter table ex_users modify user_pw varchar2(100);

-- modify constraint는 제공되지 않음!
-- 제약조건의 이름을 유지한채 내용만 변경하는 기능은 없음.
-- 제약조건 삭제(drop constraint) 후 제약조건 추가(add constraint)를 해야 함.


-- 1. emp 테이블을 test_emp 테이블로 복사
-- insert into 테이블이름1 select * from 테이블이름2;
create table test_emp as
select * from emp;

-- 데이터 복사 없이 같은 모양의 테이블을 생성
--create table test_emp 
--as select * from emp where empno = -1;

-- 테이블이 생성된 경우에 테이블 내용 복사
--insert into table_name 
--select * from emp;

desc test_emp;

-- test_emp 테이블에서
-- 2. etc 컬럼 추가. 20 byte 문자열.
alter table test_emp
add etc varchar2(20);

desc test_emp;

-- 3. etc 컬럼을 remark 이름으로 변경.
alter table test_emp
rename column etc to remark;

-- 4. remark 컬럼의 데이터 타입을 100 byte 문자열로 변경.
alter table test_emp
modify remark varchar2(100);

-- 5. empno 컬럼에 primary key 제약조건 추가.
alter table test_emp
add constraint pk_test_emp primary key (empno);

-- 6. dept 테이블의 deptno 컬럼에 고유키 제약조건을 추가한 후, 
-- deptno 컬럼이 dept 테이블의 deptno를 참조하도록 외래키 제약 조건 추가
alter table dept
modify deptno primary key;

delete from test_emp where empno = 1004;

alter table test_emp
add constraint fk_test_emp foreign key (deptno) references dept (deptno);

-- 7. ename 컬럼에 not null 제약조건 추가
alter table test_emp 
modify ename constraint nn_test_emp_ename not null;

-- 8. 7에서 만든 제약조건 삭제
alter table test_emp drop constraint nn_test_emp_ename;

-- 9. comm 컬럼 삭제

-- 10. test_emp 테이블 삭제
