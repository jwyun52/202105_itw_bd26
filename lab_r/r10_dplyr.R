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

# 수학 점수가 평균 이상인 학생들의 id, 수학점수
mean(exam$math)  # 수학 점수 평균
subset <- filter(exam, math >= mean(math))  
#> 수학 점수가 평균 이상인 학생들만 갖는 데이터 프레임
select(subset, id, math)

exam %>%  # exam 데이터 프레임에서
  filter(math >= mean(math)) %>%  # 수학 점수가 평균 이상인 학생들.
  select(id, math)  # id, math 변수를 선택.

exam %>%  # exam 데이터 프레임에서
  select(id, math) %>%  # id, math 변수를 선택
  filter(math >= mean(math))  # 수학 점수가 평균 이상인 학생들.

# 수학점수가 평균 이상인 학생들의 id, science
exam %>% 
  filter(math >= mean(math)) %>% 
  select(id, science)

# exam %>% 
#   select(id, science) %>% 
#   filter(math >= mean(math))
#> 에러 발생


# arrange() 함수
# exam 데이터 프레임을 수학점수 오름차순으로 출력
arrange(exam, math)
exam %>% arrange(math)

# 수학점수 내림차순 정렬
arrange(exam, desc(math))  # desc(math) 대신에 -math를 사용해도 됨.
exam %>% arrange(desc(math))

# 수학점수 상위 5명 출력
head(exam, n = 5)
exam %>% head(n = 5)
exam %>%              # exam 데이터 프레임에서
  arrange(-math) %>%  # 수학 점수 내림차순 정렬
  head(n = 5)         # 위에서 5개 행 선택

head(arrange(exam, -math), n = 5)

# 수학 점수 하위 5명 출력
exam %>%              # exam 데이터 프레임에서
  arrange(-math) %>%  # 수학 점수 내림차순 정렬
  tail(n = 5)         # 아래에서 5개 행 선택
exam %>% arrange(math) %>% head(n = 5)


# 1반 학생들 중에서 수학점수 상위 2명의 id, math, science를 출력
exam %>%                  # exam 데이터 프레임에서
  filter(class == 1) %>%  # class가 1인 학생들
  arrange(-math) %>%      # 수학점수 내림차순 정렬
  head(n = 2) %>%         # 상위 2명
  select(id, math, science)  # id, math, science 컬럼 선택

# 1, 2반 학생들 중에서 수학 점수 상위 4명의 id, class, math, science 출력
exam %>% 
  filter(class == 1 | class == 2) %>%   # class %in% c(1, 2)
  arrange(-math) %>% 
  head(n = 4) %>% 
  select(-english)  # select(id, class, math, science)


# mutate() 함수
mutate(exam, total = math + english + science)
#> mutate() 함수는 원본 데이터 프레임 exam을 수정하는 것이 아니라,
# 파생변수가 추가된 새로운 데이터 프레임을 만들어서 리턴함.

# 비교
exam$total <- exam$math + exam$english + exam$science
#> exam 데이터 프레임에 total 변수가 추가됨.

exam <- read.csv(file = 'datasets/csv_exam.csv')
# exam 데이터 프레임에 세과목 총점(total), 세과목 평균(average) 파생변수 추가
mutate(exam, 
       total = math + english + science,
       average = total / 3)


# summarise() 함수
# 비교
summary(exam)
summary(exam$math)

# exam 데이터 프레임에서 math의 평균, 표준편차 계산
mean(exam$math)  # 평균(mean)
sd(exam$math)  # 표준 편차(standard deviation)
median(exam$math)  # 중앙값(median)

summarise(exam, mean_math = mean(math), sd_math = sd(math))

# 변수(객체) <- 값
# 함수(파라미터 = 값)

exam %>% 
  summarise(mean_math = mean(math), sd_math = sd(math))

# 1반 학생들의 과학 점수 평균과 표준편차
exam %>% 
  filter(class == 1) %>% 
  summarise(mean_sci = mean(science), sd_sci = sd(science))

class_1 <- filter(exam, class == 1)
class_1
mean(class_1$science)
sd(class_1$science)

summarise(class_1, mean(science), sd(science))
