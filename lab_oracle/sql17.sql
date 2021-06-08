-- DML(Data Manipulation Language): insert, update, delete
-- insert: 테이블에 레코드(행)을 삽입(추가)
-- update: 테이블의 특정 컬럼의 값을 변경(갱신)
-- delete: 테이블의 레코드(행)을 삭제

-- TCL(Transaction Control Language): commit, rollback
-- commit: 테이블의 변경 내용(insert, update, delete)을 데이터베이스에 영구히 저장.
--   DML은 commit 명령 수행 후 데이터베이스에 반영됨.
--   DDL은 자동 commit.
-- rollback: 최종 commit 상태로 되돌리기.

-- insert into 테이블이름 (컬럼, ...) values (값, ...);
-- update 테이블이름 set 컬럼 = 값, ... where 조건;
-- delete from 테이블이름 where 조건;

select * from emp;

-- emp 테이블의 모든 sal을 100으로 수정
update emp set sal = 100;

select * from emp;

rollback;  -- 최종 commit 상태로 되돌리기

select * from emp;

-- emp 테이블에서 SMITH의 sal을 1000으로 업데이트
update emp
set sal = 1000
where ename = 'SMITH';

-- 사번이 7499인 직원의 급여를  2000, 수당을 500으로 업데이트.
update emp
set sal = 2000, comm = 500
where empno = 7499;

select * from emp;

create table test1234 (
    id number(2)
);
-- DDL(create, drop, alter)는 자동 commit
-- => 이전에 실행했던 update문들도 모두 commit이 됨.

select * from emp;
rollback;
select * from emp;
