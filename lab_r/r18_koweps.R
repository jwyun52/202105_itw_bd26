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

populations <- welfare %>% 
  group_by(region_code, gender) %>% 
  count()

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
# 지역별, ages의 비율 막대 그래프
