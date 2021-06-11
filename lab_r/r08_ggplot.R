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

# 자동차 구동방식(drv)별 데이터 개수
table(mpg$drv)
g + geom_bar(mapping = aes(x = drv, fill = drv))


# box plot(상자 그림): 연속형 변수의 기술 통계량 시각화
#   최솟값, 1사분위값, 중앙값(median), 3사분위값, 최댓값
# 시내주행 연비 요약 & box plot

# 고속도로 연비 요약 & box plot
