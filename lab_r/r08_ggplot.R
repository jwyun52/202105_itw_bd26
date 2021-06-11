# 변수 타입에 따른 여러가지 그래프 종류(geometry)

# histogram(히스토그램): 연속형 변수의 분포를 시각화
g <- ggplot(data = mpg)

# 시내주행 연비 분포
g + geom_histogram(mapping = aes(x = cty), bins = 10)

# 고속도로 연비 분포
g + geom_histogram(mapping = aes(x = hwy), bins = 10,
                   color = 'black', fill = 'white')
#> color = 막대 테두리 색깔, fill = 막대 안쪽을 채우는 색깔


# 막대 그래프(bar plot): 카테고리(범주) 타입 변수의 분포
# 자동차 종류(class)별 데이터 개수
table(mpg$class)
g + geom_bar(mapping = aes(x = class))  # 세로 막대 그래프
g + geom_bar(mapping = aes(y = class))  # 가로 막대 그래프

# 자동차 연료(fl)별 데이터 개수
table(mpg$fl)
g + geom_bar(mapping = aes(x = fl, fill = fl))
#> 막대 채우기 색깔을 fl의 값에 따라서 다르게 매핑함.

g + geom_bar(mapping = aes(x = fl), fill = 'lightblue')
#> 모든 막대의 채우기 색깔을 'ligthblue' 한가지로 설정.

# 자동차 구동방식(drv)별 데이터 개수
table(mpg$drv)
g + geom_bar(mapping = aes(x = drv, fill = drv))


# box plot(상자 그림): 연속형 변수의 기술 통계량 시각화
#   최솟값, 1사분위값, 중앙값(median), 3사분위값, 최댓값
# 시내주행 연비 요약 & box plot
summary(mpg$cty)
g + geom_boxplot(mapping = aes(y = cty))
g + geom_boxplot(mapping = aes(x = cty))

# 고속도로 연비 요약 & box plot
summary(mpg$hwy)
g + geom_boxplot(mapping = aes(y = hwy))

# 자동차 구동방식별 시내주행 연비의 분포를 box plot으로 시각화
table(mpg$drv)
g + geom_boxplot(mapping = aes(x = drv, y = cty))

# scatter plot과 비교
g + geom_point(mapping = aes(x = drv, y = cty))

# 실린더 개수별 시내주행 연비 분포 시각화 - boxplot
table(mpg$cyl)
g + geom_boxplot(mapping = aes(x = as.factor(cyl), y = cty))
#> as.factor(변수): 변수를 factor(카테고리 타입 객체)로 변환.

# scatter plot과 비교
g + geom_point(mapping = aes(x = cyl, y = cty))
g + geom_point(mapping = aes(x = as.factor(cyl), y = cty))


# scatter plot(산점도 그래프): 두 변수 간의 상관관계를 시각화
# cty ~ displ 상관관계
g + geom_point(mapping = aes(x = displ, y = cty))

# hwy ~ cty 상관관계
g + geom_point(mapping = aes(x = cty, y = hwy))


# 하나의 ggplot 객체에 두개 이상의 geom 함수를 사용.
ggplot(data = mpg, mapping = aes(x = displ, y = cty)) + 
  geom_point() +
  geom_smooth()  # 회귀 곡선(regression curve)

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = cty)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(color = drv))

ggplot(data = mpg, mapping = aes(x = displ, y = cty, color = drv)) +
  geom_point() +
  geom_smooth()

# hwy ~ displ scatter plot + 회귀 곡선
# 1) 점의 색깔은 drv에 따라서 다르게 매핑.
# 회귀 곡선의 색깔도 drv에 따라서 다르게 매핑.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth()

# 2) 점의 색깔은 drv에 따라서 다르게 매핑.
# 회귀 곡선의 선 스타일이 drv에 따라서 다르게 매핑. 선 색깔은 한가지.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv))

# 3) 점의 색깔, 회귀 곡선의 색깔, 회귀 곡선의 선 스타일 모두 
# drv 값에 따라서 다르게 매핑
ggplot(data = mpg, 
       mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() +
  geom_smooth(mapping = aes(linetype = drv))


# 막대 그래프: 카테고리 변수의 (데이터 개수) 시각화
# 자동차 구동방식별 빈도수
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = drv))

# 자동차 class별, drv별 빈도수
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv))


