# kNN(k-Nearest Neighbors, k-최근접 이웃) 알고리즘을 사용한 
# 붓꽃(iris) 품종 분류(예측)

# 필요한 패키지 설치
# install.packages('class')  # classification(분류) -> knn() 함수 사용
# install.packages('gmodels')  # 혼동(오차) 행렬 - CrossTable() 사용

# 필요한 패키지 로드
library(tidyverse)
library(class)
library(gmodels)
search()

# 데이터 셋 준비
?datasets::iris  # help(도움말) 페이지
iris <- datasets::iris  # datasets 패키지의 iris 데이터를 메모리에 복사.
head(iris)
tail(iris)
str(iris)

# 데이터 탐색(exploration)
# 탐색적 데이터 분석(EDA: exploratory data analysis)
summary(iris)
#> 수치형 데이터 - 기술 통계량, factor 타입 데이터 - 빈도수

table(iris$Species)

# 데이터의 분포 - 상자 그림, 히스토그램
# 붓꽃 품종별 4개 특성(S.L, S.W, P.L, P.W)의 boxplot을 그려보세요.
ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Length))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Sepal.Width))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Petal.Length))

ggplot(data = iris) +
  geom_boxplot(mapping = aes(x = Species, y = Petal.Width))

# Petal.Length ~ Petal.Width 산점도 그래프.
# 점의 색깔을 붓꽃의 품종에 따라서 다르게 표현.
ggplot(data = iris) +
  geom_point(mapping = aes(x = Petal.Width, y = Petal.Length,
                           color = Species))

# kNN 알고리즘 적용 예측
# 1) iris 데이터 프레임을 특성(features)과 타겟(target)으로 분리.
# 2) 전체 데이터 셋을 훈련 셋과 테스트 셋으로 나눔.
# 인덱스를 사용해서 데이터 프레임에서 원소를 선택하는 방법
# data_frame[row_index, column_index]
iris[1, 1]  #> 1번째 행, 1번째 열의 원소
iris[1:2, 1]  #> 1~2번째 행, 1번째 열의 원소
iris[1, 1:2]  #> 1번째 행, 1~2번째 열의 원소
iris[1:3, 1:4]  #> 1~3번째 행, 1~4번째 열의 원소
iris[c(1, 3, 5), ]  #> 1, 3, 5번 행의 모든 열의 원소

# data_frame[column_index] = data_frame[, column_index]
iris[1]  #> 1번째 열의 모든 원소
iris[1:4]  #> 1~4번째 열의 모든 원소
iris[c(1, 3, 5)]  #> 1, 3, 5번째 열의 모든 원소
