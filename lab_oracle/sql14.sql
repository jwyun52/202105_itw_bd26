-- 테이블 생성, 제약조건 정의 연습

/*
테이블 이름: customers(고객)
컬럼:
  1) cust_id: 고객 아이디. 8 ~ 20 byte의 문자열. primary key.
  2) cust_pw: 고객 비밀번호. 8 ~ 20 byte의 문자열. not null.
  3) cust_email: 고객 이메일. 100 byte 문자열.
  4) cust_gender: 고객 성별. 1자리 정수. 기본값 0. (0, 1, 2) 중 1개 값만 가능.
  5) cust_age: 고객 나이. 3자리 정수. 기본값 0. 0 이상 200 이하의 정수만 가능.
*/


/*
테이블 이름: orders(주문)
컬럼:
  1) order_id: 주문번호. 4자리 정수. primary key.
  2) order_date: 주문 날짜. 기본값은 현재 시간.
  3) order_method: 주문 방법. 8 byte 문자열. ('online', 'offline') 중 1개 값만 가능.
  4) cust_id: 주문 고객 아이디. 20 byte 문자열. not null. customers(cust_id)를 참조.
*/

