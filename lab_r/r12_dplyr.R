# dplyr 패키지를 사용한 데이터 조작(manipulation) - 그룹별 요약
# summarise(), group_by()

# summarise() 함수와 함께 사용되는 통계(집계) 함수들:
#   mean(): 평균
#   median(): 중앙값
#   var(): 분산(variance)
#   sd(): 표준편차(standard deviation)
#   sum(): 합계
#   max(), min(): 최댓값, 최솟값
#   IQR(): Inter-Quartile Range. 3rd Quartile - 1st Quartile
#   n(): 빈도수

library(tidyverse)

exam <- read.csv(file = 'datasets/csv_exam.csv')
head(exam)

# exam 데이터 프레임에서 수학 점수의 
# 중앙값, 평균, 분산, 표준편차, 최댓값, 최솟값 출력.
median(exam$math)
mean(exam$math)

exam %>% 
  summarise(median_math = median(math),
            mean_math = mean(math),
            var_math = var(math),
            sd_math = sd(math),
            max_math = max(math),
            min_math = min(math))

# exam 데이터 프레임의 row(observation) 개수
str(exam)
exam %>% summarise(n = n())
# summarise(n = n())을 간단히 표현한 함수: count()
exam %>% count()


# 그룹별 통계: 데이터 프레임 %>% group_by() %>% summarise(통계 함수)
# exam 데이터 프레임에서 class별 학생수
exam %>% 
  group_by(class) %>% 
  summarise(n = n())

exam %>% group_by(class) %>% count()

# group_by(x) %>% summarise(n = n())
# 위와 동일한 결과: count(x)
exam %>% count(class)
count(exam, class)

# exam 데이터 프레임에서 
# class별 영어 점수의 평균, 표준편차, 최댓값, 최솟값 출력
df <- exam %>% 
  group_by(class) %>% 
  summarise(mean = mean(english), sd = sd(english),
            max = max(english), min = min(english))
df

# 반별 영어 점수 평균 시각화 -> 막대 그래프
# geom_col(): 데이터 프레임에서 변수 2개를 x축과 y축에 mapping시킨 막대 그래프.
ggplot(data = df) +
  geom_col(mapping = aes(x = class, y = mean))

# 반별 인원수 -> 막대 그래프
# geom_bar(): 데이터 프레임에서 카테고리 변수의 빈도수 막대 그래프.
exam %>% count(class)

ggplot(data = exam) +
  geom_bar(mapping = aes(x = class))

# dplyr 패키지를 사용해서 가공된 데이터를 파이프 연산자( %>% )를 사용해서
# ggplot() 함수에게 전달할 수 있음.
exam %>%  # exam 데이터 프레임에서
  group_by(class) %>%  # class별로 그룹 지어서
  summarise(mean_eng = mean(english)) %>%  # class별 영어 점수 평균 계산
  ggplot() +
  geom_col(mapping = aes(x = class, y = mean_eng))


# ggplot2::mpg 데이터 프레임 사용
head(mpg)

# 자동차 class별 자동차 수 계산, 시각화(막대 그래프)
table(mpg$class)  #> 분할표, 도수분포표
count(mpg, class)  #> 데이터 프레임

ggplot(mpg) +
  geom_bar(mapping = aes(x = class))

# 자동차 class별 시내 연비의 평균 계산, 시각화(막대 그래프)
df <- mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty))
df

ggplot(df) +
  geom_col(mapping = aes(x = class, y = mean_cty))

