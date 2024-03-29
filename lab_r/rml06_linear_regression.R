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
# expenses ~ age + sex + bmi + children + smoker + region
lin_reg1 <- lm(formula = expenses ~ ., data = train_set)
summary(lin_reg1)  # adjusted R^2 = 0.7467

# 선형 모델에서 훈련 셋의 예측값
train_predictions <- predict(lin_reg1, train_set)
head(train_predictions)  # 예측값 일부
head(train_set$expenses)  # 실제값 일부
head(lin_reg1$residuals)  # 잔차 (= 실제값 - 예측값) 일부

# 훈련 셋 평가 점수
rmse(train_set$expenses, train_predictions)  #> 6030.798

# 테스트 셋 예측값
test_predictions <- predict(lin_reg1, test_set)
head(test_predictions)  # 예측값
head(test_set$expenses)  # 실제값

# 테스트 셋 평가 점수
rmse(test_set$expenses, test_predictions)  #> 6096.883
# 일반적으로 훈련 셋의 평가 점수가 테스트 셋의 평가 점수보다 좋은 경우가 많음.
# 과대적합(over-fitting, over-fitted):
# 훈련 셋의 평가 점수가 테스트 셋의 평가 점수보다 크게 차이가 나도록 좋은 경우.

# 선형 모델을 변경 후 평가
# expenses ~ age + sex + bmi + smoker
lin_reg2 <- lm(formula = expenses ~ age + sex + bmi + smoker,
               data = train_set)
summary(lin_reg2)  #> adjusted R^2 = 0.7441

# 훈련 셋 평가
train_predictions2 <- predict(lin_reg2, train_set)
rmse(train_set$expenses, train_predictions2)  #> 6073.699

# 테스트 셋 평가
test_predictions2 <- predict(lin_reg2, test_set)
rmse(test_set$expenses, test_predictions2)  #> 6126.623


# 비선형 항을 추가한 모델
# expenses ~ age + age^2 + sex + bmi + smoker
insurance_df$age_square <- insurance_df$age ** 2  # 파생 변수 추가
head(insurance_df)
train_set <- insurance_df[1:tr_size, ]
test_set <- insurance_df[(tr_size + 1):n, ]

lin_reg3 <- lm(formula = expenses ~ age + age_square + sex + bmi + smoker,
               data = train_set)
summary(lin_reg3)  #> Adjusted R-squared:  0.7451

train_predictions3 <- predict(lin_reg3, train_set)
rmse(train_set$expenses, train_predictions3)  #> 6058.983

test_predictions3 <- predict(lin_reg3, test_set)
rmse(test_set$expenses, test_predictions3)  #> 6104.617


# bmi 변수의 값에 따른 파생 변수 추가
# overweight = 1 if bmi >= 30, overweight = 0 if bmi < 30
# model4: expenses ~ .
# model5: expenses ~ age + age_square + bmi + smoker
#                    + overweight + overweight * smoker
