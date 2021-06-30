# 선형 회귀(linear regression) - 수치 예측

# 필요한 패키지 로드
library(tidyverse)
search()

# 데이터 준비
url <- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/heights.csv'
heights_df <- read.csv(url)
head(heights_df)
summary(heights_df)

# 데이터 탐색(EDA)
# father 변수의 분포 - boxplot, histogram
ggplot(data = heights_df) +
  geom_boxplot(mapping = aes(y = father))

ggplot(data = heights_df) +
  geom_histogram(mapping = aes(x = father),
                 bins = 10, color = 'black', fill = 'lightgray')

# son 변수의 분포
ggplot(data = heights_df) +
  geom_boxplot(mapping = aes(y = son))

ggplot(data = heights_df) +
  geom_histogram(mapping = aes(x = son),
                 bins = 10, color = 'black', fill = 'lightgray')

# 두 변수의 상관 관계 - 산점도 그래프
ggplot(data = heights_df,
       mapping = aes(x = father, y = son)) +
  geom_point(color = 'darkgray', alpha = 0.5) +
  geom_smooth(method = 'lm')
# lm: linear modeling(선형 모델링). 선형 회귀.
#   y(종속변수) ~ x(독립변수)의 선형 관계를 찾는 것.
#   y = a + b * x의 관계식에서 직선의 y절편 a와 직선의 기울기 b를 찾는 것.

# 선형 회귀 결과 분석
lin_reg <- lm(formula = son ~ father,  # y ~ x 형식
              data = heights_df)
lin_reg  #> 선형 회귀식 공식, 계수들
summary(lin_reg)
#> F-statistic(F-통계량)의 p-value(유의확률)이 0.05보다 작음.
#  -> 우리가 찾은 선형 모델이 통계적으로 유의하다.
#> R^2 점수, 조정된 R^2 점수: 선형 모델이 전체 데이터를 설명하는 정도.
#  -> R^2 점수는 1에 가까울 수록 좋은 모델.
