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
    constraint pk_ex04_id primary key (ex_id),
    constraint nn_ex04_name check (ex_name is not null)
);

-- 테이블 이름: ex_05
-- 컬럼:
--   (1) id: 숫자 2자리, PK
--   (2) name: 문자열 10글자, NN
--   (3) code: 문자열 3 byte, 중복되지 않는 값
--   (4) create_date: 날짜, 기본값 현재시간
--   (5) age: 숫자 3자리, 0보다 크거나 같아야 함.
--   (6) gender: 문자열 1 byte, 'M' 또는 'F'만 가능
-- 모든 제약 조건을 inline으로
create table ex_05 (
    id          number(2)
                constraint pk_ex05_id primary key,
    name        varchar2(10 char)
                constraint nn_ex05_name not null,
    code        varchar2(3 byte)
                constraint uq_ex05_code unique,
    create_date date default sysdate,
    age         number(3)
                constraint ck_ex05_age check (age >= 0),
    gender      varchar2(1 byte)
                constraint ck_ex05_gender check (gender in ('M', 'F'))
                -- check (gender = 'M' or gener = 'F')
);

-- 테이블 이름: ex_06
-- ex_05 테이블과 구조/제약조건이 같은 테이블을 생성.
-- 제약조건 정의와 컬럼 정의를 구분
create table ex_06 (
    id          number(2),
    name        varchar2(10 char),
    code        varchar2(3 byte),
    create_date date default sysdate,
    age         number(3),
    gender      varchar2(1 byte),
    -- constraints
    constraint pk_ex06_id primary key (id),
    constraint nn_ex06_name check (name is not null),
    constraint uq_ex06_code unique (code),
    constraint ck_ex06_age check (age >= 0),
    constraint ck_ex06_gender check (gender in ('M', 'F'))
);




