# 복지 패널 데이터 분석 - 직종, 성별, 월소득

# 라이브러리 로드
library(tidyverse)
library(ggthemes)

# RData 파일을 로드
load(file = 'datasets/koweps.RData')

# 로딩된 데이터 확인
head(welfare)

# 가장 많은 사람이 종사하는 직종 상위 10개 이름과 종사자 수
# 시각화

