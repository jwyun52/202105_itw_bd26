# Random Forest를 사용한 붓꽃 품종 예측
# Random Forest: Bagging을 이용한 Decision Tree들의 Ensemble 학습 방법.
# Bagging(Bootstrap Aggregating)
#   훈련 셋에서 "중복을 허용해서(bootstrap)" 무작위로 샘플링해서
#   훈련 셋의 부분집합들을 만드는(aggregate) 방법.
# 앙상블(ensemble) 학습 방법:
#   1) 하나의 머신 러닝 알고리즘을 여러개의 훈련 셋에서 학습시킴.
#   2) 여러개의 머신 러닝 알고리즘을 하나의 훈련 셋에서 학습시킴.

# 필요한 패키지 설치
# install.packages('randomForest')

# 필요한 패키지를 로드
library(tidyverse)  # 전처리, 가공, 시각화
library(randomForest)  # randomForest()
library(gmodels)  # CrossTable()
search()

# 데이터 준비
iris <- datasets::iris
str(iris)  #> 종속변수 Species가 factor 타입 -> 분류

# 훈련 셋(80%), 테스트 셋(20%) 분리 -> random sampling
set.seed(42)
idx <- sample(150)
idx
train_idx <- idx[1:120]
test_idx <- idx[121:150]

train_set <- iris[train_idx, ]  # 훈련 셋
test_set <- iris[test_idx, ]  # 테스트 셋

table(train_set$Species)
table(test_set$Species)

# 알고리즘 훈련
forest_clf <- randomForest(formula = Species ~ .,
                           data = train_set)
forest_clf
#> OOB(Out-Of-Bagging) 샘플에서의 추정 오차 - 5%
# OOB sample: Bagging 방법에서 추출되지 못하고 남아 있는 샘플들
# OOB 샘플의 추정 오차는 테스트 셋에서의 추정 오차와 비슷한 경향.

# 훈련 셋에서 훈련 성과 평가
train_predictions <- predict(forest_clf, train_set)
mean(train_set$Species == train_predictions)  #> 1

# 테스트 셋에서 평가
test_predictions <- predict(forest_clf, test_set)
mean(test_set$Species == test_predictions)  #> 0.933
CrossTable(test_set$Species, test_predictions, prop.chisq = FALSE)


# -----
# Random Forest를 사용한 wisc_bc_data.csv 데이터 암 예측

# 데이터 준비
url <- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/wisc_bc_data.csv'
wisc_bc_data <- read.csv(url)
str(wisc_bc_data)

# diagnosis 변수를 factor 타입으로 변환
wisc_bc_data$diagnosis <- factor(wisc_bc_data$diagnosis,
                                 levels = c('B', 'M'),
                                 labels = c('Benign', 'Malignant'))
table(wisc_bc_data$diagnosis)

# train/test 분리
n <- nrow(wisc_bc_data)
tr_size <- round(n * 0.8)
train_set <- wisc_bc_data[1:tr_size, 2:32]
test_set <- wisc_bc_data[(tr_size + 1):n, 2:32]
#> id 변수는 제외함.

# Random Forest 모델 훈련
forest_clf <- randomForest(formula = diagnosis ~ .,
                           data = train_set)
forest_clf  #> OOB estimate of  error rate: 5.27%

# 훈련 셋 평가
train_predictions <- predict(forest_clf, train_set)
mean(train_set$diagnosis == train_predictions)  #> 1

# 테스트 셋 평가
test_predictions <- predict(forest_clf, test_set)
mean(test_set$diagnosis == test_predictions)  #> 0.982
CrossTable(test_set$diagnosis, test_predictions, prop.chisq = FALSE)
