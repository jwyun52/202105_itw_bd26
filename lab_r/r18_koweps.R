# 복지 패널 데이터 분석 - 지역별 통계

# 필요한 라이브러리 로드
library(tidyverse)
search()

# RData 파일 로드
load(file = 'datasets/koweps.RData')

head(welfare)

# 지역별 인구수, 시각화
table(welfare$region_code)
sum(table(welfare$region_code))

ggplot(data = welfare) +
  geom_bar(mapping = aes(y = region_code))

# 지역별 성별 인구수, 시각화(성별 인구수, 성비)
table(welfare$gender)
sum(table(welfare$gender))

populations <- welfare %>% count(region_code, gender)
  # group_by(region_code, gender) %>% 
  # count()

populations

ggplot(data = populations) +
  geom_col(mapping = aes(x = region_code, y = n, fill = gender))

ggplot(data = populations) +
  geom_col(mapping = aes(x = region_code, y = n, fill = gender),
           position = 'dodge')

ggplot(data = welfare) +
  geom_bar(mapping = aes(x = region_code, fill = gender),
           position = 'dodge')
#> 두개의 막대가 옆으로 나란히 배치. 인구수를 표현.

ggplot(data = welfare) +
  geom_bar(mapping = aes(x = region_code, fill = gender),
           position = 'fill')
#> 모든 막대의 길이가 1.0으로 동일. 성비를 색깔로 표현.

# pivoting
populations %>% 
  pivot_wider(names_from = gender, values_from = n) %>% 
  mutate(Female_Ratio = Female / (Male + Female))

# 지역별, 연령대별 인구수 -> pivot
welfare %>% 
  count(region_code, age_range) %>% 
  pivot_wider(names_from = age_range, values_from = n)

ggplot(data = welfare) +
  geom_bar(mapping = aes(y = region_code, fill = age_range),
           position = 'fill')

# 지역별, 연령대별, 성별 인구수 -> 지역별 통계가 행(row)가 되도록 pivot
welfare %>% 
  count(region_code, age_range, gender) %>% 
  pivot_wider(names_from = c(age_range, gender), values_from = n)
  # pivot_wider(names_from = gender, values_from = n)


# welfare 데이터 프레임에 ages 파생변수를 추가
#   ages = 'young', if age < 30
#   ages = 'middle', if age < 60
#   ages = 'old', if age >= 60
# 파생변수 ages를 factor로 변환
welfare <- welfare %>% 
  mutate(ages = ifelse(age < 30, 'young',
                       ifelse(age < 60, 'middle', 'old')))
welfare

welfare$ages <- factor(welfare$ages,
                       levels = c('young', 'middle', 'old'))
# level과 동일한 label을 사용하는 경우 labels 파라미터는 생략.

welfare
table(welfare$ages)

# 지역별, ages별 인구수 테이블
welfare %>% count(region_code, ages) %>% 
  pivot_wider(names_from = ages, values_from = n)

# 지역별, ages의 비율 막대 그래프
ggplot(data = welfare) +
  geom_bar(mapping = aes(y = region_code, fill = ages),
           position = 'fill')


# 지역별 평균 월소득, 시각화
income_by_region <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region_code) %>% 
  summarise(mean_income = mean(income))

income_by_region

ggplot(data = income_by_region) +
  geom_col(mapping = aes(x = mean_income,
                         y = reorder(region_code, mean_income)))

# 지역별 ages별 평균 월소득, 시각화
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region_code, ages) %>% 
  summarise(mean_income = mean(income)) %>% 
  ggplot() +
  geom_col(mapping = aes(x = region_code, y = mean_income, 
                         fill = ages),
           position = 'dodge')
  

# 지역별 성별 평균 월소득, 시각화
welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(region_code, gender) %>% 
  summarise(mean_income = mean(income)) %>% 
  ggplot() +
  geom_col(mapping = aes(x = region_code, y = mean_income, 
                         fill = gender),
           position = 'dodge')

# 데이터 저장
save(koweps, welfare, file = 'datasets/koweps.RData')


# 지역별 직종별 평균 월소득
# 서울 지역에서 평균 월소득 상위 5개 직종
welfare %>% 
  filter(region_code == '서울' & !is.na(income) & !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), count = n()) %>% 
  arrange(-mean_income) %>% 
  head(n = 5)

# 부산/경남/울산 지역에서 평균 월소득 상위 5개 직종
welfare %>% 
  filter(region_code == '부산/경남/울산' & !is.na(income) & !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), count = n()) %>% 
  arrange(-mean_income) %>% 
  head(n = 5)

# 강원/충북 지역에서 평균 월소득 상위 5개 직종
welfare %>% 
  filter(region_code == '강원/충북' & !is.na(income) & !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), count = n()) %>% 
  arrange(-mean_income) %>% 
  head(n = 5)


df <- welfare %>% 
  filter(!is.na(income) & !is.na(job)) %>% 
  group_by(region_code, job) %>% 
  summarise(mean_income = mean(income), count = n())

df

df %>% filter(region_code == '강원/충북') %>% 
  arrange(-mean_income) %>% 
  head(n = 5)
