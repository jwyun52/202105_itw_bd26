# 선형 회귀(linear regression)을 이용한 의료비 예측

# 필요한 패키지 로드
library(tidyverse)
#install.packages('ModelMetrics')
library(ModelMetrics)  # 모델 성능 지표 계산
search()

# 데이터 준비
url <- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/insurance.csv'
insurance_df <- read.csv(url)
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

table(insurance_df$sex)
table(insurance_df$smoker)
table(insurance_df$region)
