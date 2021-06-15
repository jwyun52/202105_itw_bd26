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

# 자동차 제조사별 고속도로 연비 평균이 높은 순위 1 ~ 5위 출력, 시각화
df <- mpg %>%  # mpg 데이터 프레임
  group_by(manufacturer) %>%  # 제조사별로 그룹 지어서 
  summarise(mean_hwy = mean(hwy)) %>%  # 제조사별 고속도로 연비 평균 계산
  arrange(-mean_hwy) %>%  # 연비 평균 내림차순으로 정렬
  head(n = 5)  # 상위 5개 선택
df
ggplot(data = df) +
  geom_col(mapping = aes(x = manufacturer, y = mean_hwy))

ggplot(data = df) +
  geom_col(mapping = aes(x = reorder(manufacturer, -mean_hwy), 
                         y = mean_hwy)) +
  xlab('manufacturer')

# 자동차 회사별 compact 자동차 모델 수
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == 'compact') %>% 
  count()  # summarise(n = n())

mpg %>% 
  filter(class == 'compact') %>% 
  count(manufacturer)

# 비교:
mean(mpg$hwy)
mpg %>%  # mpg 데이터 프레임에서
  filter(hwy >= mean(hwy)) %>%  # 고속도로 연비가 평균(23.4) 이상인
  group_by(class) %>%  # class별로 그룹 지어서
  count()  # 각 그룹별 개수

mpg %>% 
  group_by(class) %>%  # class별로 그룹 지어서
  filter(hwy >= mean(hwy)) %>%  # 그룹 안에서 그룹 평균 이상인
  count()  # 그룹별 개수

# 'suv' 자동차의 통합 연비((시내 + 고속도로)/2)을 구하고,
# 회사별 통합 연비 평균의 내림차순으로 정렬해서 1~3위 출력
df <- mpg %>% 
  filter(class == 'suv') %>%  # 'suv'만 선택
  mutate(total_mpg = (cty + hwy) / 2) %>%  # 통합연비 파생변수 추가
  group_by(manufacturer) %>%  # 회사별로 그룹
  summarise(mean_tot_mpg = mean(total_mpg)) %>%  # 회사별 통합연비 평균
  arrange(-mean_tot_mpg) %>%  # 내림차순 정렬
  head(n = 3)  # 1~3위 선택

df

ggplot(data = df) +
  geom_col(mapping = aes(x = reorder(manufacturer, -mean_tot_mpg), 
                         y = mean_tot_mpg)) +
  xlab('manufacturer') +
  ggtitle('회사별 통합 연비') +
  theme(plot.title = element_text(hjust = 0.5))


