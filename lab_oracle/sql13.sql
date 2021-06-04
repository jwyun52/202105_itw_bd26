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

insert into ex_02 values (1, '가나다라');  
-- 실패: PK는 unique해야 함.

insert into ex_02 (ex_name) values ('홍길동');  
-- 실패: PK는 not null이어야 함.

insert into ex_02 values (2, '홍길동');  -- 성공
insert into ex_02 values (3, '홍길동');  -- 성공

insert into ex_02 (ex_id) values (4);
-- 실패: ex_name 컬럼이 NN인 제약 조건을 위배.


-- 제약조건의 이름과 내용을 함께 명시
create table ex_03 (
    ex_id   number(2) constraint pk_ex03_id primary key,
    ex_name varchar2(10 char) constraint nn_ex03_name not null
);


-- 컬럼 정의와 제약 조건 정의를 구분해서 테이블 생성
create table ex_04 (
    -- 컬럼 정의
    ex_id   number(2),
    ex_name varchar2(10 char),
    -- 제약 조건 정의
    
);
