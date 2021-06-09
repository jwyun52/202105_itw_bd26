# 데이터프레임(Data Frame): 표 형태(행/열)로 데이터를 저장하는 타입.
#   데이터베이스의 테이블(table) 구조와 비슷.
#   데이터프레임의 컬럼은 한가지 타입의 자료들을 저장.
# observation(관찰값, 관측치): 데이터프레임의 행(row). 테이블의 레코드.
# variable(변수): 데이터프레임의 열(column).

stu_no <- 1:4  # 학생 번호
stu_name <- c('aaa', 'bbb', 'ccc', 'ddd')  # 학생 이름
score <- c(100, 50, 70, 80)  # 성적

# 번호, 이름, 성적을 저장하는 데이터프레임
students <- data.frame(stu_no, stu_name, score)
students

# df$col: 데이터프레임에서 특정 컬럼의 내용을 출력
students$stu_name
# select stu_name from students;

exam_scores <- data.frame(korean = c(90, 100, 80),
                          english = c(99, 88, 77),
                          math = c(10, 20, 30))
exam_scores

