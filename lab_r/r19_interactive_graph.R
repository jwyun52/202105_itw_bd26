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



