# interactive graph

# 필요한 패키지 설치
# install.packages('plotly')
# 패키지 홈페이지: https://plotly.com/r/

# 패키지 로드
library(tidyverse)
library(plotly)
search()


# ggplot2::mpg 데이터 셋을 시각화
# hwy ~ displ 산점도 그래프. drv에 따라서 점의 색깔을 다르게 표현.
# 1) ggplot 그래프 작성, 저장 -> ggplotly()에 전달.
g <- ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv))
ggplotly(g)

# 2) plot_ly() 함수를 사용해서 interactive graph 그리기.
plot_ly(data = mpg, x = ~displ, y = ~hwy, color = ~drv,
        type = 'scatter')

# hwy ~ displ 산점도 그래프
# 점의 색깔은 drv에 따라서, 점의 모양은 class에 따라서 다르게 설정.
graph <- ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, 
                           color = drv, shape = class))
graph  # 그래프 화면 출력
ggplotly(graph)

plot_ly(data = mpg, x = ~displ, y = ~hwy, type = 'scatter',
        color = ~drv, symbol = ~class)

# drv별 hwy의 boxplot
g <- ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = drv, y = hwy))
g
ggplotly(g)

plot_ly(data = mpg, type = 'box', x = ~drv, y = ~hwy)


# ggplot2::economics 데이터 셋을 사용
head(economics)

# 인구수(pop) 시계열 그래프
g <- ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = pop))
g
ggplotly(g)

plot_ly(data = economics, type = 'scatter', mode = 'lines',
        x = ~date, y = ~pop)

# 개인저축률(psavert) 시계열 그래프
g <- ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = psavert))
g
ggplotly(g)

plot_ly(data = economics, mode = 'lines',
        x = ~date, y = ~psavert)
# 선그래프를 그릴 때 type = 'scatter' 생략 가능.

# economics 데이터 프레임에 실업률(단위 %) 파생변수를 추가
# 실업률 시계열 그래프
economics <- economics %>% 
  mutate(unemploy_pct = (unemploy / pop) * 100)

head(economics)

g <- ggplot(data = economics) +
  geom_line(mapping = aes(x = date, y = unemploy_pct))
g
ggplotly(g)

plot_ly(data = economics, type = 'scatter', mode = 'lines',
        x = ~date, y = ~unemploy_pct)

# 개인저축률, 실업률을 하나의 그래프에
g <- ggplot(data = economics, mapping = aes(x = date)) +
  geom_line(mapping = aes(y = psavert, color = 'psavert')) +
  geom_line(mapping = aes(y = unemploy_pct, color = 'unemploy_pct')) +
  ylab('Ratio')
g
ggplotly(g)

plot_ly(data = economics, type = 'scatter', mode = 'lines',
        x = ~date, y = ~psavert, name = '개인저축률') %>% 
  add_trace(y = ~unemploy_pct, name = '실업률')

# plot_ly() 함수
#> type = 'scatter', mode = 'markers': 산점도 그래프
#> type = 'scatter', mode = 'lines': 선 그래프
#> type = 'scatter', mode = 'lines+markers': 선 그래프 + 마커(점)
