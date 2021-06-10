# 데이터 프레임 파악하기(탐색적 데이터 분석)

# 필요한 패키지를 메모리에 로딩.
library(tidyverse)
# 로딩된 패키지 확인
search()

# ggplot2::mpg 예제 데이터 셋을 사용.
# mpg 데이터 프레임의 첫 5개 row를 출력
# mpg: mile per gallon(mile/gallon)
head(mpg, n = 5)
#> tibble: 데이터 프레임을 확장한(더 많은 기능을 가지고 있는) 자료 구조.

tail(mpg, n = 5)

# 데이터 프레임 구조
str(mpg)

# 기술 통계량 요약
summary(mpg)
#> 수치 데이터: 최솟값, 최댓값, 평균, 중앙값, ...
#> 문자열 데이터: null이 아닌 데이터의 개수

# Quick Plot을 사용한 데이터 시각화(visualization)
# 시내주행 연비(mpg$cty)
summary(mpg$cty)

# 히스토그램(histogram): 연속형 변수의 최솟값과 최댓값 사이의 범위를
# (일정한) 구간으로 나눠서, 그 구간 안에 포함된 데이터의 개수를
# 막대로 표시한 그래프.
qplot(x = cty, data = mpg, bins = 8)
