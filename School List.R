
url <- 'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EB%AC%B8%EC%9D%98%EC%B4%88'

selector <-'#main_pack > section.sc_new.cs_school._cs_school > div > div.api_cs_wrap > 
div.school_area > div:nth-child(2) > ul > li:nth-child(2) > span.txt > span > span'

library
html <- read_html(url)
node <- html_node(html,selector)
text <- html_text(node)
text

install.packages('enframe')
library(readxl)
library(tibble)


list <- read_excel('초중등.xlsx')
list
list <- list[,4]
list
list[1]
list <- deframe(list)
list
Encoding(list[1])

add1 <- c()

for (i in 1:36) {
  name <- URLencode(list[i])
  url <- paste0('https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=',name)
  html <- read_html(url)
  node <- html_node(html,selector)
  text <- html_text(node)
  add1 <- c(add1,text)
}

write.csv(add1,'중등.csv')
