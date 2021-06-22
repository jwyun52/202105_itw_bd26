# install.packages('패키지이름')
#   CRAN(R 패키지 중앙 저장소)에 등록된 패키지를 다운받고 설치.
# CRAN에 등록되어 있지 않고, 개인/단체 저장소(github)에 저장된 패키지를
# 설치할 필요가 있을 수도 있음.
# devtools::install_github() 함수를 사용해서 github에 저장된 패키지를
# 설치할 수 있음.

# install.packages('devtools')

# devtools::install_github('cardiomoon/kormaps2014')

search()
library(tidyverse)
library(ggiraphExtra)
library(kormaps2014)

# kormaps2014 패키지에 포함된 한국 지도 데이터
head(kormap1)
str(kormap1)
distinct(kormap1, SIDO_CD)

str(kormap2)
kormap2 %>% distinct(sigungu_cd) %>% head(10)

str(kormap3)

# ggplot을 사용해서 kormap1~3 지도를 표현.
ggplot(data = kormap1,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'gray', fill = 'white') +
  coord_quickmap()

ggplot(data = kormap2,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'gray', fill = 'white') +
  coord_quickmap()

ggplot(data = kormap3,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'gray', fill = 'white') +
  coord_quickmap()

# kormap2 데이터 프레임을 사용해서 서울 지도 표현.
# 시군구 이름으로 filtering
gangnam <- kormap2 %>% 
  filter(sigungu_nm %in% c('강남구', '서초구', '송파구'))
head(gangnam)
tail(gangnam)

ggplot(data = gangnam,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'darkgray', fill = 'white') +
  coord_quickmap()


code <- c('1101', '1102', '1201', '1202')
str_starts(code, '11')

# kormap2의 sigungu_cd가 '11'로 시작하는 row 선택 -> 서울시
seoul <- kormap2 %>% 
  filter(str_starts(sigungu_cd, '11'))
head(seoul)
tail(seoul)

kormap2 %>% filter(str_starts(sigungu_cd, '21')) %>% tail()  # 부산

ggplot(data = seoul,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(color = 'darkgray', fill = 'white') +
  coord_quickmap()

# kormap1 지도 위에 korpop1 데이터를 시각화
head(kormap1)
head(korpop1)

# kormap1과 korpop1 데이터 프레임을 left_join.
# join 기준 컬럼: code
df <- left_join(kormap1, korpop1, by = 'code')
head(df)

ggplot(data = df,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(mapping = aes(fill = 총인구_명), color = 'darkgray') +
  coord_quickmap() +
  scale_fill_continuous(low = 'white', high = 'darkorange')

# ggChoropleth 함수 이용 - 전국 시도별 인구수 지도에 표시
ggChoropleth(data = korpop1,
             map = kormap1,
             mapping = aes(map_id = code, fill = 총인구_명),
             interactive = TRUE)

# kormap2 지도 데이터와 korpop2 인구 데이터를 사용해서
# 전국의 시군구별 인구수를 지도에 표시
# ggplot, ggChoropleth
head(kormap2)
head(korpop2)

df2 <- left_join(kormap2, korpop2, by = c('region' = 'code'))

ggplot(data = df2,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(mapping = aes(fill = 총인구_명), color = 'darkgray') +
  coord_quickmap() +
  scale_fill_continuous(low = 'white', high = 'darkorange')

ggChoropleth(data = korpop2,
             map = kormap2,
             mapping = aes(map_id = code, fill = 총인구_명), 
             interactive = TRUE)

# kormap2 지도 데이터와 korpop2 인구 데이터를 사용해서
# 서울의 구별 인구수를 지도에 표시
# ggplot, ggChoropleth
seoul_pop <- filter(korpop2, str_starts(code, '11'))
head(seoul_pop)
tail(seoul_pop)

df3 <- left_join(seoul, seoul_pop, by = c('region' = 'code'))
head(df3)

ggplot(data = df3,
       mapping = aes(x = long, y = lat, group = group)) +
  geom_polygon(mapping = aes(fill = 총인구_명), color = 'darkgray') +
  coord_quickmap() +
  scale_fill_continuous(low = 'white', high = 'darkorange')

ggChoropleth(data = seoul_pop,
             map = seoul,
             mapping = aes(map_id = code, fill = 총인구_명),
             interactive = TRUE)
