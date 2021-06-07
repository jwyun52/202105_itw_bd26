-- call_chicken.csv 파일 다운로드
-- 테이블 이름: call_chicken
-- 컬럼: call_date, call_day, gu, ages, gender, calls
create table call_chicken (
    call_date   date,
    call_day    varchar2(1 char),
    gu          varchar2(5 char),
    ages        varchar2(5 char),
    gender      varchar2(1 char),
    calls       number(4)
);

select * from call_chicken;

-- 1. 통화건수의 최댓값, 최솟값
select max(calls), min(calls) from call_chicken;

-- 2. 통화건수가 최댓값이거나 또는 최솟값인 레코드를 출력
select * from call_chicken
where calls = (select max(calls) from call_chicken) 
    or calls = (select min(calls) from call_chicken) ;

select * from call_chicken
where calls = (select max(calls), min(calls) from call_chicken);
-- 에러 발생: 다중 컬럼 서브 쿼리를 컬럼 하나와 비교할 수 없음!

select max(calls) from call_chicken
union
select min(calls) from call_chicken;

select * from call_chicken
where calls in (
    -- 다중 행 서브쿼리
    select max(calls) from call_chicken
    union
    select min(calls) from call_chicken
);

-- 3. 통화요일별 통화건수의 평균

-- 4. 연령대별 통화건수의 평균

-- 5. 통화요일별, 연령대별 통화건수의 평균

-- 6. 구별, 성별 통화건수의 평균

-- 7. 요일별, 구별, 연령대별 통화건수의 평균

-- 3 ~ 7 문제의 출력은 통화건수 평균의 내림차순 정렬. 소숫점 1자리까지 반올림.

