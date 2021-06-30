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



