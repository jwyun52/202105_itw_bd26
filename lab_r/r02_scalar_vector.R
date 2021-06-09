# scalar(스칼라): 한개의 값이 저장된 객체(object), 변수(variable)
# vector(벡터): 한가지 타입(유형)의 여러개의 값이 저장된 객체.

# scalar의 예:
x <- 100  # x: 숫자 한개를 저장하고 있는 스칼라
name <- '오쌤'  # name: 문자열 한개를 저장하고 있는 스칼라
# R에서 문자열은 작은따옴표('') 또는 큰따옴표("")로 묶음.

is_big <- TRUE  # is_big: 논릿값(logical type: TRUE, FALSE) 한개를 저장하는 스칼라.
# R의 키워드들은 대/소문자를 구분함!
is_big <- (5 > 3)
is_big <- (5 < 3)

# 비교 연산자: >, >=, <, <=, ==, !=
is_same <- (3 == 5)


# vector의 예:
# c(): combine 함수
# 함수(function): 기능
#   argument(인수): 함수를 호출할 때 함수에게 전달하는 값.
#   return value(반환 값): 함수가 기능을 수행한 후 그 결과로 반환하는 값.

numbers <- c(1, 2, 3, 10, 20, 100)
# numbers: 숫자(numeric values) 6개를 저장하는 벡터.
numbers

student_names <- c('안상진', '김태현', '장윤희')
# student_names: 문자열(characters, string) 3개를 저장하는 벡터.
student_names

booleans <- c(TRUE, FALSE, FALSE, TRUE)
# booleans: 논릿값 4개를 저장하는 벡터.
booleans

# 벡터의 인덱스(index): 벡터에서 원소(element)들이 저장된 위치.
numbers
# 벡터 numbers에서 첫번째 원소를 선택
numbers[1]
# numbers의 4번째 원소를 선택
numbers[4]

# 특정 인덱스 범위(range) 안에 있는 원소들을 선택
numbers[2:4]  # 2 <= index <= 4

# 특정 인덱스들에 있는 원소들을 선택
numbers[c(1, 3, 5)]

# 인덱스의 원소를 제외하고 나머지 원소들을 선택
numbers[-1]
# numbers[2:6]
# numbers에서 인덱스 1, 2을 제외하고 나머지 모든 원소를 선택
numbers[c(-1, -2)]
