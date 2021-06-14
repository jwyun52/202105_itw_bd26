# ggplot2::mpg 데이터 프레임 사용

library(tidyverse)

head(mpg)

# cyl가 4인 자동차들의 고속도로 연비 평균
mpg %>%  # mpg 데이터 프레임에서
  filter(cyl == 4) %>%  # cyl가 4인 부분집합
  summarise(mean_hwy = mean(hwy))  # hwy의 평균

# 자동차 종류(class)가 'compact'인 자동차들의 고속도로 연비 평균
mpg %>% 
  filter(class == 'compact') %>% 
  summarise(mean_hwy = mean(hwy))

mpg %>% 
  filter(class == 'compact') %>% 
  summarise(mean_hwy = mean(mpg$hwy))  #> 위와 다른 결과

# 자동차 종류가 'suv'인 자동차의 hwy 평균


# 제조사의 빈도수 - table
# 빈도수가 가장 높은 제조사 2개의 hwy 평균



