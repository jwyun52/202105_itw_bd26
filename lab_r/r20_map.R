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

