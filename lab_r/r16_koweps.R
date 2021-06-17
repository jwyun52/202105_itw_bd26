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

# is.na(x): x가 NA이면 TRUE, NA가 아니면 FALSE를 반환
numbers
is.na(numbers)
!is.na(numbers)

income_by_gender <- welfare %>% 
  filter(!is.na(income)) %>%  # income이 NA가 아닌 데이터 선택
  group_by(gender) %>%  # gender별로 그룹을 묶어서
  summarise(mean_income = mean(income))  # income의 평균을 계산
income_by_gender

ggplot(data = income_by_gender) +
  geom_col(mapping = aes(x = gender, y = mean_income, fill = gender))

#####
numbers
mean(numbers, na.rm = T)  # (95+100+90)/3
numbers <- ifelse(is.na(numbers), 0, numbers)
numbers
mean(numbers)  # (95+100+90+0)/4
#####


# 연령대에 따라서 소득의 변화가 있을까?
# 나이(age: 2015년 기준 나이) 변수 추가
welfare$age <- 2015 - welfare$birth
head(welfare)

# 나이별 인구수, 시각화
table(welfare$age)
ggplot(data = welfare) +
  geom_bar(mapping = aes(x = age))

# 나이별 월소득 평균
welfare %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income, na.rm = TRUE))
# NaN: Not a Number

income_by_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))

# 나이별 월소득 평균 시각화
ggplot(data = income_by_age) +
  geom_line(mapping = aes(x = age, y = mean_income))
