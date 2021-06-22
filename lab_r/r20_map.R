# 지도 위에 데이터 표현하기

# 지도 데이터(위도, 경도)를 가지고 있는 패키지 설치
# install.packages('maps')

# ggplot2::coord_map() 함수가 필요로 하는 패키지 설치
# install.packages('mapproj')

# 패키지 로드
library(tidyverse)
search()

# 지도 데이터 불러오기: ggplot2::map_data(map = '지도이름')
#> 지도 데이터를 읽어서 데이터 프레임을 생성.
usa <- map_data(map = 'usa')
head(usa)
str(usa)

# usa 데이터 프레임의 변수들:
#> long: longitude(경도). 
#     영국 그리니치 천문대를 기준으로 동(+)/서(-) 방향의 좌표.
#> lat: latitude(위도)
#     적도를 기준으로 남(-)/북(+) 방향의 좌표
#> group: 지도에서 함께 연결할 위도/경도 점들의 그룹(나라, 주, 도시, ...)
#> order: 위도/경도 점들을 연결하는 순서

ggplot(data = usa,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'black', fill = 'white') +
  coord_quickmap()
  # coord_map(projection = 'polyconic')

usa_state <- map_data(map = 'state')
head(usa_state)

table(usa$region)
table(usa$subregion)

table(usa_state$region)
table(usa_state$subregion)

ggplot(data = usa_state,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'black', fill = 'white') +
  coord_quickmap()

# map_data() 함수를 사용해서 세계지도를 그릴 수 있는 데이터 프레임 생성.
# ggplot을 사용해서 지도를 그려보세요.
world <- map_data(map = 'world')
head(world)
distinct(world, region)

ggplot(data = world, 
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'black', fill = 'white') +
  coord_map(projection = 'polyconic') # coord_quickmap()

# map_data() 함수를 사용해서 세계지도에서 한국, 중국, 일본 region을 선택.
# 선택한 region들을 지도로 표현
asia <- map_data(map = 'world', 
                 region = c('South Korea', 'North Korea', 'China', 'Japan'))
ggplot(data = asia,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'black', fill = 'white') +
  coord_map(projection = 'polyconic')


# 미국 주(state) 지도 위에 통계 데이터 표현
# 미국 state의 지도 정보
head(usa_state)

# usa_state 변수의 구분되는 값들
distinct(usa_state, region)  # 49개 주 이름 - 소문자

# datasets::USArrests 예제 데이터 셋 - 범죄 통계 데이터
head(USArrests)
str(USArrests)
#> 50 observations, 4 variables
#> 미국 주 이름들이 컬럼(변수)이 아니라 행 이름으로 설정되어 있음!
#> 지도 데이터와 범죄 통계 데이터를 merge(join)하기 위해서는
# 행 이름들을 컬럼(변수)으로 변환해야 할 필요가 있음.
us_arrests <- rownames_to_column(USArrests, var = 'state')
str(us_arrests)
head(us_arrests)

# head(distinct(usa_state, region))
usa_state %>% distinct(region) %>% head()
