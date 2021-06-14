# dplyr 패키지를 사용한 데이터 탐색
# select(): 데이터 프레임에서 원하는 컬럼(변수)를 선택.
# filter(): 데이터 프레임에서 조건을 만족하는 행(관찰값)을 선택.
# arrange(): 데이터 프레임을 출력할 때, 변수를 기준으로 정렬.
# mutate(): 파생 변수를 추가.
# group_by(): 그룹별 묶기.
# summarize(), summarise(): 통계값 계산(통계 함수 적용).

# dplyr 패키지의 대부분의 함수들은 첫번째 argument로 데이터 프레임을 전달함!
# dplyr 패키지의 대부분의 함수들은 새로운 데이터 프레임을 생성해서 리턴!
# 즉, 원본 데이터 프레임은 변경되지 않음.


# 필요한 패키지 로드
library(tidyverse)

# csv_exam.csv 파일을 읽어서 데이터 프레임을 생성.
exam <- read.csv(file = 'datasets/csv_exam.csv')

head(exam)
tail(exam)

# select() 함수:
# exam 데이터 프레임에서 id와 math를 출력
select(exam, id, math)

# exam 데이터 프레임에서 id, math, english, science를 선택
select(exam, id, math, english, science)
# exam 데이터 프레임에서 class 변수를 제외하고 모든 변수 선택.
select(exam, -class)


# 파이프(pipe) 연산자 %>%:
# dplyr 패키지를 로드했을 때 사용 가능.
# data_frame %>% function(): 
#   data_frame을 function의 첫번째 argument로 전달해줌.
# Ctrl+Shift+M: 파이프 연산자
exam %>% select(id, math)
exam %>% select(-class)


# filter() 함수
# exam 데이터 프레임에서 class가 1인 observation 출력
# 비교 연산자: ==, !=, >, >=, <, <=
# 논리 연산자(and, or, not): &, |, !
filter(exam, class == 1)
exam %>% filter(class == 1)

# exam 데이터 프레임에서 class가 1또는 2인 observation 출력
filter(exam, class == 1 | class == 2)
exam %>% filter(class == 1 | class == 2)

# 변수이름 %in% 벡터
filter(exam, class %in% c(1, 2))

# 1반 학생 중에서 수학 점수가 50점 이상인 학생들의 정보
filter(exam, class == 1 & math >= 50)
exam %>% filter(class == 1 & math >= 50)
