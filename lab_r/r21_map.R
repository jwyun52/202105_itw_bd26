# install.packages('패키지이름')
#   CRAN(R 패키지 중앙 저장소)에 등록된 패키지를 다운받고 설치.
# CRAN에 등록되어 있지 않고, 개인/단체 저장소(github)에 저장된 패키지를
# 설치할 필요가 있을 수도 있음.
# devtools::install_github() 함수를 사용해서 github에 저장된 패키지를
# 설치할 수 있음.

# install.packages('devtools')

# devtools::install_github('cardiomoon/kormaps2014')

search()
library(tidyverse)
library(ggiraphExtra)
library(kormaps2014)

# kormaps2014 패키지에 포함된 한국 지도 데이터
head(kormap1)
