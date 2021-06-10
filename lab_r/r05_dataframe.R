# 데이터 프레임의 구조, 요약 정보 확인

# csv 파일을 읽어서 데이터 프레임 생성.
exam <- read.csv(file = 'datasets/csv_exam.csv')

# 데이터 프레임 전체 출력
exam

# 데이터 프레임에서 데이터 일부만 출력
# head(df, n = 6): 데이터 프레임 df에서 첫 6개 row를 출력. 
# tail(df, n = 6): 데이터 프레임 df에서 마지막 6개 row를 출력.
# 출력할 row의 개수는 파라미터 n으로 설정.
head(exam)
tail(exam, n = 5)

# str(df): 데이터 프레임의 구조(structure) - 컬럼 이름, 타입, 데이터 일부, ...
str(exam)

# 데이터 타입:
#   int: integer. 정수
#   dbl: double. 실수
#   chr: character. 문자(열)
#   logi: logical. 논릿값
