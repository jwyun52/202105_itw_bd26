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
