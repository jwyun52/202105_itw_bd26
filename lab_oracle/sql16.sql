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


-- alter table 테이블이름 변경내용;
-- 이름 변경(rename): (1) 테이블 이름 변경, (2) 컬럼 이름 변경, (3) 제약조건 이름 변경
