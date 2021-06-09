# 파일(csv, xls, xlsx 등)을 읽어서 데이터프레임 생성하기

# 파일 경로(path) 표기 방법:
# 1. 절대 경로(absolute path):
#   최상위 디렉토리(root directory)에서부터 파일이 있는 위치까지 모두 표기하는 방법.
#     C:\study\lab_r\exam_scores2.csv
#     /Users/abc/Documents/exam_scores2.csv
# 2. 상대 경로(relative path):
#   현재 작업 디렉토리(CWD: current working directory)를 기준으로 파일이 있는 위치까지 찾아서 표기하는 방법.
#     CWD가 C:\study\lab_r인 경우, exam_scores2.csv
#     CWD가 C:\study인 경우, lab_r\exam_scores2.csv

# 상대 경로 표기법에서
# .: 현재 디렉토리
#   ./exam_scores2.csv
# ..: 상위 디렉토리
#   ../abc.txt

# 디렉토리 구분자: MS Windows는 '\'를 사용. 
# 윈도우즈를 제외한 다른 모든 OS는 '/'를 사용.
# 따옴표('', "") 안에서 '\'는 특별한 의미를 갖기 때문에,
# 디렉토리 구분자로 '\'를 사용하는 것은 권장하지 않음!
# R에서는 OS에 상관없이 디렉토리 구분자를 '/'를 사용하는 것을 권장.
file_path <- 'C:/study/lab_r/exam_scores2.csv'
file_path


# CSV 파일을 읽어서 데이터프레임 생성하기
df <- read.csv(file = 'exam_scores2.csv')
df
