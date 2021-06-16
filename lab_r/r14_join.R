# join: inner, left, right, full

library(tidyverse)
search()

emp <- data.frame(empno = c(101, 102, 103),
                  ename = c('scott', 'king', 'allen'),
                  deptno = c(10, 20, 40))
emp

dept <- data.frame(deptno = c(10, 20, 30),
                   dname = c('HR', 'IT', 'SALES'))
dept

# inner_join(left_df, right_df, by)
# left_df %>% inner_join(right_df, by)
# join 조건 by에 전달하는 컬럼(변수) 이름이 두 테이블에서 같은 경우,
# by는 생략해도 됨.
inner_join(emp, dept, by = 'deptno')
inner_join(emp, dept)
emp %>% inner_join(dept)

# left_join(df1, df2, by)
# df1 %>% left_join(df2, by)
emp %>% left_join(dept)
#> NA(Not Available): 결측값, 누락값. SQL에서 NULL.

# right_join
right_join(emp, dept)

# full_join
full_join(emp, dept)

# join할 때 join 조건 컬럼의 이름이 서로 다른 경우:
dept2 <- data.frame(dno = c(10, 20, 30), 
                    dept_name = c('영업', '총무', '인사'))
dept2

emp %>% inner_join(dept2, by = c('deptno' = 'dno'))
emp %>% left_join(dept2, by = c('deptno' = 'dno'))
emp %>% right_join(dept2, by = c('deptno' = 'dno'))
emp %>% full_join(dept2, by = c('deptno' = 'dno'))

# by = c('x1' = 'y1', 'x2' = 'y2')

# emp 데이터 프레임에 mgr 변수를 추가
emp$mgr <- c(102, NA, 102)
emp

# inner_join
inner_join(emp, emp, by = c('mgr' = 'empno'))


# join 연습
fuel <- data.frame(fl = c('c', 'd', 'e', 'p', 'r'),
                   price = c(2.3, 2.4, 2.1, 2.7, 2.2))
fuel

head(mpg)
#> mpg$fl: 자동차가 사용하는 연료 종류

# mpg와 fuel 데이터 프레임을 inner join
# join 결과 데이터 프레임에 price_per_mile 파생 변수를 추가
# price_per_mile: 도심 1 mile을 주행할 때 드는 연료비
# model, cty, fl, price, price_per_mile를 출력
mpg %>% 
  inner_join(fuel) %>% 
  mutate(price_per_mile = price / cty) %>% 
  select(model, cty, fl, price, price_per_mile)
