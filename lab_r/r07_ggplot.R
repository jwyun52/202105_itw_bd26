# ggplot2::ggplot() 함수를 사용한 데이터 시각화

library(tidyverse)
search()

# ggplot() 함수 사용방법: ggplot() + geom_xxx() + 옵션들 + ...
#   (1) ggplot(): 그래프를 그릴 준비
#   (2) geom_function(): 그래프 종류(geometry function)
#   (3) 옵션 함수: 배경 테마, 폰트, ...

# cty(시내주행 연비) ~ displ(배기걍) scatter plot(산점도 그래프)
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point()

# ggplot()의 parameter:
#   data = 데이터 프레임
#   mapping = aes(): x축, y축 매핑, 색상 매핑, 스타일 매핑, ...

# aes() 함수: aesthetic function
#   데이터 프레임의 "변수들을 사용"해서 그래프의 심미적인 요소들을 설정.
#   데이터 프레임의 "변수의 값에 따라서" 달라지는 색깔, 모양, 크기 등을 설정.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = cty))

# cty ~ displ, 점의 색깔은 구동방식(drv)에 따라 다르게 표현.
# 모든 그래프의 x축, y축, 색깔 공통으로 적용
ggplot(data = mpg, mapping = aes(x = displ, y = cty, color = drv)) +
  geom_point()

# 모든 그래프의 x축, y축 공통 사용, 색깔은 점 그래프에만
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point(mapping = aes(color = drv))

# 점 그래프에만 x축, y축 색깔 적용
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = cty, color = drv))

# aes()에서의 color 설정과 aes() 밖에서의 color 설정 비교
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
    geom_point(color = 'blue')

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point(mapping = aes(color = 'blue'))

# hwy ~ displ 관계 scatter plot
# drv의 값에 따라서 점의 색깔을 다르게 설정.
# class(차의 크기에 따른 분류)의 값에 따라서 점의 모양을 다르게 설정.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, 
                           color = drv, shape = class))

table(mpg$class)


# ggplot2의 여러가지 옵션들
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  ggtitle('배기량 vs 연비') +  # 그래프 제목
  xlab('배기량(L)') +  # x축 레이블(label)
  ylab('고속도로 연비(mile/gallon)')





