# 선형 회귀(linear regression)을 이용한 의료비 예측

# 필요한 패키지 로드
library(tidyverse)
#install.packages('ModelMetrics')
library(ModelMetrics)  # 모델 성능 지표 계산
search()

# 데이터 준비
url <- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/insurance.csv'
insurance_df <- read.csv(url, stringsAsFactors = TRUE)
head(insurance_df)
# bmi(body mass index) = 몸무게 / 키^2  (kg/m^2)
# expenses: 의료비 지출 - 관심 변수, 종속 변수
# age, sex, bmi, children, smoker, region - 설명 변수, 독립 변수
# expenses ~ age + sex + bmi + children + smoker + region
# expenses = b0 + b1 * age + b2 * sex + b3 * bmi 
#            + b4 * children + b5 * smoker + b6 * region
# 선형 회귀를 하려면 모든 변수들은 숫자 타입이어야 함!
# 문자열 타입을 factor 타입으로 변환하면, 
# lm() 함수는 factor 타입을 숫자(0, 1, ...)로 변환해서 
# 회귀식의 계수들을 찾아줌.

str(insurance_df)
# table(insurance_df$sex)
# table(insurance_df$smoker)
# table(insurance_df$region)
summary(insurance_df)

# read.csv() 함수를 사용할 때 stringsAsFactors = FALSE인 경우에,
# insurance_df$sex <- as.factor(insurance_df$sex)
# insurance_df$sex <- factor(insurance_df$sex, levels = c())

# 데이터 탐색
# 각 변수의 분포 시각화: boxplot, histogram, bar plot
# 변수들 간의 상관 관계 시각화:
# expneses ~ age, expenses ~ bmi, ... 산점도 그래프

# graphics::pairs() 함수: 산포도 행렬(scatter plot matrix, pair plot)
pairs(insurance_df)
pairs(insurance_df[c('age', 'bmi', 'children', 'expenses')])

# install.packages('psych')
library(psych)  # psych::pairs.panels() 함수를 사용하기 위해서
# 향상된 산포도 행렬(pair plot)
# 산점도 그래프, 히스토그램, 상관 계수
pairs.panels(insurance_df[c('age', 'bmi', 'children', 'expenses')])

# cor(x, y): 변수 x와 y의 상관계수 계산
cor(insurance_df$expenses, insurance_df$age)
# -1 <= 상관계수 <= 1
# 상관계수가 +1에 가까울 수록 양의 상관관계가 크다고 말함.
# 상관계수가 -1에 가까울 수록 음의 상관관계가 크다고 말함.
# 상관계수가 0에 가까울 수록 상관관계가 없다(작다)고 말함.
# (주의) 상관관계과 인과관계는 다름!

# 전체 데이터 셋을 훈련 셋(80%)과 테스트 셋(20%)로 분리
n <- nrow(insurance_df)  # 전체 샘플 개수
tr_size <- round(n * 0.8)  # 훈련 데이터 샘플 개수
train_set <- insurance_df[1:tr_size, ]  # 훈련 셋
test_set <- insurance_df[(tr_size + 1):n, ]  # 테스트 셋

# 모델 훈련
