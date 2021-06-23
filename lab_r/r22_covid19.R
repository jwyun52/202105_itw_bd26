# https://github.com/nytimes/covid-19-data
#   미국의 Covid-19(코로나 바이러스) 데이터가 업데이트되는 github
# github의 설명을 잘 읽어보고, 
# 미국의 주별 코로나 확진자 수를 지도 위에 시각화하기 위해 필요한 데이터를 찾아서
# 미국 지도 위에 가장 최근 날짜의 확진자 수를 시각화해보세요.
# 날짜별 (미국 전체의) 코로나 확진자 수를 시계열 그래프로 시각화해보세요.

# 필요한 라이브러리 로드
library(tidyverse)
library(ggiraphExtra)
library(plotly)
search()

# 미국 주별/날짜별 코로나 확진자/사망자 수가 정리된 CSV 파일 저장 URL 주소
file_url <- 'https://github.com/nytimes/covid-19-data/raw/master/us-states.csv'

# URL 주소로부터 CSV 파일을 직접 읽고 데이터 프레임 생성
us_covid <- read.csv(file = file_url)
head(us_covid)
tail(us_covid)
str(us_covid)

# 미국 지도 데이터
us_map <- map_data(map = 'state')
head(us_map)
tail(us_map)

# us_map 데이터 프레임과 us_covid 데이터 프레임을 join
# join 조건: us_map 데이터 프레임의 region과 us_covid 데이터 프레임의 state
# us_covid 데이터 프레임에서 주 이름들을 소문자로 변환
us_covid$state <- str_to_lower(us_covid$state)
distinct(us_covid, state)

# 코로나 데이터에서 가장 최근 날짜만 선택 -> 지도 위에 시각화
us_covid_recent <- filter(us_covid, date == '2021-06-21')
head(us_covid_recent)
tail(us_covid_recent)

# 코로나 데이터의 fips 컬럼
us_covid_recent %>% distinct(state, fips) %>% head()

# 지도 데이터와 가장 최근 날짜 코로나 데이터를 join
us_map_covid <- left_join(us_map, us_covid_recent, 
                          by = c('region' = 'state'))
head(us_map_covid)


# 서울시 코로나 확진자 수 시각화

