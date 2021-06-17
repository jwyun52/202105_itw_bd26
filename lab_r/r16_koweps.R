# 복지 패널 데이터 분석

# 필요한 패키지 로드
library(tidyverse)

# RData 파일을 메모리(Global Env.)에 로드(load)
load(file = 'datasets/koweps.RData')

# 로드한 데이터 프레임 확인
head(koweps)
head(welfare)

# welfare 데이터 프레임 사용
# 성별에 따른 월소득 격차가 있는지?
# 성별 월소득의 평균 계산, 시각화

welfare %>% 
  group_by(gender) %>% 
  summarise(mean_income = mean(income))
#> 월소득 평균이 NA가 됨

numbers <- c(90, 100, 95, NA)
mean(numbers, na.rm = TRUE) 
# na.rm 파라미터: NA들을 제거하고 계산할 지(TRUE), 
# 제거하지 않고 계산할 지(FALSE)를 설정.

welfare %>% 
  group_by(gender) %>% 
  summarise(mean_income = mean(income, na.rm=TRUE))
