# 복지 패널 데이터 분석 - 직종, 성별, 월소득

# 라이브러리 로드
library(tidyverse)
library(ggthemes)

# RData 파일을 로드
load(file = 'datasets/koweps.RData')

# 로딩된 데이터 확인
head(welfare)

# 가장 많은 사람이 종사하는 직종 상위 10개 이름과 종사자 수
# 시각화
job_top10 <- welfare %>% 
  filter(!is.na(job)) %>%  # job이 NA가 아닌 데이터들을 선택
  count(job) %>%   # group_by(job) %>% summarise(n = n()): 직종별 종사자 수 
  arrange(-n) %>%  # 변수 n 값의 내림차순 정렬
  head(n = 10)  # 상위 10개 행 선택

job_top10

ggplot(data = job_top10) +
  geom_col(mapping = aes(x = reorder(job, -n),
                         y = n))

ggplot(data = job_top10) +
  geom_col(mapping = aes(x = n,
                         y = reorder(job, n)))

# 남성이 가장 많이 종사하는 직종 상위 10개 직종 이름과 종사자 수
# 시각화
job_male_top10 <- welfare %>% 
  filter(!is.na(job) & gender == 'Male') %>% # 직업이 있는 남성
  count(job) %>% # 직종별 숫자
  arrange(-n) %>% # 내림차순 정렬
  head(n = 10) # 상위 10개

job_male_top10

ggplot(data = job_male_top10) +
  geom_col(mapping = aes(x = n,
                         y = reorder(job, n)))

# 여성이 가장 많이 종사하는 직종 상위 10개 직종 이름과 종사자 수
# 시각화
job_female_top10 <- welfare %>% 
  filter(!is.na(job) & gender == 'Female') %>% # 직업이 있는 여성
  count(job) %>% # 직종별 숫자
  arrange(-n) %>% # 내림차순 정렬
  head(n = 10) # 상위 10개

job_female_top10

ggplot(data = job_female_top10) +
  geom_col(mapping = aes(x = n,
                         y = reorder(job, n)))

# 종사자 수가 성별로 차이가 많은 직종 상위 10개
# 1) (여성 숫자 - 남성 숫자) 내림차순 정렬 상위 10개
# 2) (남성 숫자 - 여성 숫자) 내림차순 정렬 상위 10개
job_gender <- welfare %>% 
  filter(!is.na(job)) %>% # 직업이 있는 데이터만 선택
  count(job, gender) %>% # job별, gender별 종사자 수
  pivot_wider(names_from = gender, values_from = n) %>% 
  # names_from: 컬럼 이름으로 사용할 값들이 있는 변수
  # values_from: pivot 테이블에 채워질 값들이 있는 변수
  replace(is.na(.), 0) %>% # pivot 테이블의 모든 NA를 0으로 대체
  mutate(diff = Female - Male) # 파생변수(남녀 종사자 수 차이) 추가

job_gender

# 1) 여성이 남성보다 더 많이 일하는 직종 - diff 내림차순 정렬
job_gender %>% 
  arrange(-diff) %>% 
  head(n = 10)

# 2) 남성이 여성보다 더 많이 일하는 직종 - diff 오름차순 정렬
job_gender %>% 
  arrange(diff) %>% 
  head(n = 10)


# 여성 종사자 비율이 높은 직종 상위 10개
# 남성 종사자 비율이 높은 직종 상위 10개
# job_gender 데이터 프레임에 파생변수 추가
# female_ratio = female / (female + male)
# male_ratio = male / (female + male)
job_gender <- job_gender %>% 
  mutate(female_ratio = Female / (Female + Male),
         male_ratio = Male / (Female + Male))

job_gender

# 여성 비율 상위 10개 직종
job_gender %>% 
  arrange(-female_ratio) %>% 
  head(n = 10)

job_gender %>% 
  arrange(-male_ratio) %>% 
  head(n = 10)

# 직종별 평균 월소득 상위 10개 직종 이름, 시각화
income_by_job <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), n = n()) %>% 
  arrange(-mean_income)

income_by_job_top10 <- head(income_by_job, n = 10)
income_by_job_top10

ggplot(data = income_by_job_top10) +
  geom_col(mapping = aes(x = mean_income, 
                         y = reorder(job, mean_income)))

# 직종별 평균 월소득 하위 10개 직종 이름, 시각화
income_by_job_bottom10 <- tail(income_by_job, n = 10)
income_by_job_bottom10

ggplot(data = income_by_job_bottom10) +
  geom_col(mapping = aes(x = mean_income,
                         y = reorder(job, -mean_income)))

# 직종별 종사자 수 20명 이상인 직종에서 평균 월소득 상/하위 10개 직종
top10 <- income_by_job %>% 
  filter(n >= 20) %>% 
  head(n = 10)
top10

bottom10 <- income_by_job %>% 
  filter(n >= 20) %>% 
  tail(n = 10)
bottom10

# 남성 평균 월소득 상위 10개 직종
welfare %>% 
  filter(!is.na(income) & !is.na(job) & gender == 'Male') %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), n = n()) %>% 
  arrange(-mean_income) %>% 
  head(n = 10)

# 여성 평균 월소득 상위 10개 직종
welfare %>% 
  filter(gender == 'Female' & !is.na(income) & !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), n = n()) %>% 
  arrange(-mean_income) %>% 
  head(n = 10)

# 남성 평균 월소득 상위 10개 직종. 직종별 남성 인구가 10명 이상인 경우.
welfare %>% 
  filter(!is.na(income) & !is.na(job) & gender == 'Male') %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), n = n()) %>% 
  filter(n >= 10) %>% 
  arrange(-mean_income) %>% 
  head(n = 10)

# 여성 평균 월소득 상위 10개 직종. 직종별 여성 인구가 10명 이상인 경우.
welfare %>% 
  filter(gender == 'Female' & !is.na(income)  & !is.na(job)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income), n = n()) %>% 
  filter(n >= 10) %>% 
  arrange(-mean_income) %>% 
  head(n = 10)

