# wisc_bc_data.csv: 위스콘신 대학 유방암 데이터 프레임
# kNN 알고리즘을 사용해서 암 유무를 예측

# 필요한 패키지 로드
library(tidyverse)  # 데이터 전처리, 가공, 시각화, ...
library(class)  # classification: knn() 함수
library(gmodels)  # CrossTable() 함수 - 오차(혼동) 행렬
search()


# 데이터 준비
file_path <- 'https://github.com/JakeOh/202105_itw_bd26/raw/main/datasets/wisc_bc_data.csv'
wisc_bc_data <- read.csv(file_path)
head(wisc_bc_data)
tail(wisc_bc_data)
str(wisc_bc_data)
summary(wisc_bc_data)  # 기술 통계량 요약

# diagnosis 변수에 있는 값들
table(wisc_bc_data$diagnosis)
#> B(Benign): 양성 종양(암이 아님.)
#> M(Malignant): 악성 종양(암)

# diagnosis 변수를 factor 타입으로 변환
wisc_bc_data$diagnosis <- factor(wisc_bc_data$diagnosis,
                                 levels = c('B', 'M'),
                                 labels = c('Benign', 'Malignant'))
summary(wisc_bc_data)

# as.xyz() 종류의 함수들: 데이터의 타입을 변환
# as.character(), as.integer(), as.numeric(), as.data.frame(), as.factor()

# 데이터 셋을 특성(features)과 타겟(target)으로 분리
# id(환자 아이디)는 ML에서 사용되면 안되기 때문에 제거
head(wisc_bc_data)
features <- wisc_bc_data[, 3:32]  # 모든 행들,  3~32번째 열들
target <- wisc_bc_data[, 2]  # 모든 행들, 2번째 열

# 데이터 셋의 80%를 훈련 셋, 20%를 테스트 셋으로 사용
# target이 정렬된 상태가 아니기 때문에, 
# random sampling(임의 추출)을 사용하지 않고,
# 순서대로 분리해도 괜찮음.
tr_size <- round(569 * 0.8)  # 훈련 셋의 관찰값 개수

# 훈련/테스트 특성들
train_set <- features[1:tr_size, ]  # 1 ~ 455 행
test_set <- features[(tr_size + 1):569, ]  # 456 ~ 569 행

# 훈련/테스트 레이블(타겟)
train_target <- target[1:tr_size]
test_target <- target[(tr_size + 1):569]

# 훈련/테스트 레이블이 편향되지 않고 임의로 섞여 있는 지 확인
table(train_target)
prop.table(table(train_target))

table(test_target)
prop.table(table(test_target))

# knn 알고리즘 적용
test_predictions <- knn(train = train_set,
                        cl = train_target,
                        test = test_set,
                        k = 1)

# knn 알고리즘 평가
mean(test_predictions == test_target)  # 94.7%
CrossTable(x = test_target,
           y = test_predictions,
           prop.chisq = FALSE)

# 다른 k값의 결과와 비교
test_predictions <- knn(train = train_set,
                        cl = train_target,
                        test = test_set,
                        k = 3)
mean(test_predictions == test_target)  # 95.6%
CrossTable(x = test_target,
           y = test_predictions,
           prop.chisq = FALSE)

test_predictions <- knn(train = train_set,
                        cl = train_target,
                        test = test_set,
                        k = 11)
mean(test_predictions == test_target)  # 93.8%
CrossTable(x = test_target,
           y = test_predictions,
           prop.chisq = FALSE)
