# Random Forest를 사용한 의료비 예측(회귀)

# 패키지 로드
library(tidyverse)
library(randomForest)
library(ModelMetrics)
search()

# 데이터 준비
url <- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/insurance.csv'
insurance_df <- read.csv(url, stringsAsFactors = TRUE)
str(insurance_df)

# 훈련 셋, 테스트 셋 분리
n <- nrow(insurance_df)  # 전체 샘플 개수
tr_size <- round(n * 0.8)  # 훈련 셋 샘플 개수

train_set <- insurance_df[1:tr_size, ]  # 훈련 셋
test_set <- insurance_df[(tr_size + 1):n, ]  # 테스트 셋

# random forest 모델을 훈련
forest_reg <- randomForest(formula = expenses ~ ., 
                           data = train_set)
forest_reg
#> Mean of squared residuals: 23027150
#> OOB(out of bagging) 샘플에서 추정된 MSE

# 훈련 셋 평가
train_predictions <- predict(forest_reg, train_set)
head(train_predictions, n = 5)
head(train_set$expenses, n = 5)
# mean squared error
mse(train_set$expenses, train_predictions)  #> 9813250
rmse(train_set$expenses, train_predictions)  #> 3132.611

# 테스트 셋 평가
test_predictions <- predict(forest_reg, test_set)
head(test_predictions, n = 5)
head(test_set$expenses, n = 5)

mse(test_set$expenses, test_predictions)  #> 21884111
rmse(test_set$expenses, test_predictions)  #> 4678.046
