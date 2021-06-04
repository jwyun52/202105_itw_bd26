-- 제약 조건(constraints)

-- 테이블 이름: ex_02
-- 컬럼:
--   (1) ex_id: 숫자 2자리, 고유키(PK: Primary Key)
--   (2) ex_name: 문자열 10글자까지, NN(Not Null)
create table ex_02 (
    ex_id   number(2) primary key,
    ex_name varchar2(10 char) not null
);

desc ex_02;

insert into ex_02 values (1, '가나다라');  -- 성공
insert into ex_02 values (1, '가나다라');  -- 실패
insert into ex_02 (ex_name) values ('홍길동');  -- 실패
