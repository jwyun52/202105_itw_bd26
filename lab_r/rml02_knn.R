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

