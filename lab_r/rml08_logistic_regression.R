library(tidyverse)
library(gmodels)  # CrossTable() 함수

# Logistic Regression(로지스틱 회귀)를 사용한 분류
x <- seq(-5, 5, 0.001)
head(x)
tail(x)

y <- 1 / (1 + exp(-x))  # logistic 함수
head(y)
tail(y)

df <- data.frame(x, y)
head(df)

# logistic 함수 시각화
ggplot(data = df, mapping = aes(x, y)) +
  geom_line()


# Logistic regression을 사용한 암 예측
url <- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/wisc_bc_data.csv'
wisc_bc_data <- read.csv(url)
head(wisc_bc_data)
str(wisc_bc_data)

# B(일반 종양), M(악성 종양, 암)을 0과 1로 변환
wisc_bc_data$diagnosis <- ifelse(wisc_bc_data$diagnosis == 'B', 0, 1)
table(wisc_bc_data$diagnosis)

# 훈련 셋(80%), 테스트 셋(20%) 분리
n <- nrow(wisc_bc_data)
tr_size <- round(n * 0.8)
train_set <- wisc_bc_data[1:tr_size, 2:32]  # id 제외
test_set <- wisc_bc_data[(tr_size + 1):n, 2:32]

# logistic regression 모델 훈련
log_reg <- glm(formula = diagnosis ~ .,
               data = train_set,
               family = 'binomial',  # 2항 분류(binomial classification)
               maxit = 100)  # 알고리즘이 수렴하지 않는 경고 없애기 위해서
log_reg

# 훈련 셋 예측 확률(diagnosis이 1(M)이 될 확률)
train_probabilities <- predict(log_reg, train_set, 
                               type = 'response')
head(train_probabilities)

# 훈련 셋 예측 값
train_predictions <- ifelse(train_probabilities > 0.5, 1, 0)
head(train_predictions)
table(train_predictions)

# 훈련 셋 정확도
mean(train_set$diagnosis == train_predictions)  #> 100%

# 테스트 셋 예측 확률
test_probabilities <- predict(log_reg, test_set,
                              type = 'response')
head(test_probabilities)

# 테스트 셋 예측값
test_predictions <- ifelse(test_probabilities > 0.5, 1, 0)
head(test_predictions)

# 테스트 셋 정확도
mean(test_set$diagnosis == test_predictions)  #> 96.5%

# confusion matrix(혼동 행렬, 오차 행렬)
CrossTable(test_set$diagnosis, test_predictions, 
           prop.chisq = FALSE)
