# 2015년 한국 복지 패널 데이터 분석

# 필요한 패키지 설치
# haven: SPSS, Stats, SAS 통계 프로그램에서 사용하는 파일을
# R에서 사용(read)할 때 필요한 패키지
# install.packages('haven')

# 필요한 패키지를 메모리에 로드.
library(tidyverse)
library(haven)
search()

# Koweps_hpc10_2015_beta1.sav 파일: 
#   SPSS 프로그램에서 데이터를 저장한 파일
# Koweps_Codebook.xlsx 파일: sav 파일의 변수들을 설명한 파일.
# 성별, 연령, 직종, 월수입 등을 분석
