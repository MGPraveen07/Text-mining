################  JBLearphones_ameson  ################
library(readr)
JBLearphones <- read_csv("JBLearphones.csv")
View(JBLearphones)
jbl<-as.character(JBLearphones$x)
jbl
length(jbl)
library(tm)
jbl1<- Corpus((VectorSource(jbl)))
jbl1
inspect(jbl1[2])
jbl2<- tm_map(jbl1,tolower)
inspect(jbl2[2])
jbl2<- tm_map(jbl2,removePunctuation)
jbl2<- tm_map(jbl2,removeNumbers)
inspect(jbl2[2])
jbl2<- tm_map(jbl2, removeWords, stopwords('english'))
inspect(jbl2[2])
jbl2<- tm_map(jbl2,stripWhitespace)
inspect(jbl2[2])
tdm<- TermDocumentMatrix(jbl2)
tdm
tdm1<- as.matrix(tdm)
tdm1
tdm1[10:20,1:10]
w<- rowSums(tdm1)
w
w_sub<- subset(w,w>25)
w_sub
barplot(w_sub,las = 2,col = rainbow(40))
library(wordcloud)
w_sub2<- sort(rowSums(tdm1),decreasing = TRUE)
wordcloud(words=names(w_sub2),freq =w_sub2)
wordcloud(words = names(w),freq =w, random.order = F, colors = rainbow(50),scale = c(3,1))


####################  snapdeal sandisk    ################
library(readr)
sandisk <- read_csv("sandisk.csv")
View(sandisk)
sandisk1<-as.character(sandisk$x)
sandisk1
length(sandisk1)

library(tm)
sandisk2<- Corpus((VectorSource(sandisk1)))
sandisk2
inspect(sandisk2[2])
sandisk3<- tm_map(sandisk2,tolower)
inspect(sandisk3[2])
sandisk3<- tm_map(sandisk3,removePunctuation)
sandisk3<- tm_map(sandisk3,removeNumbers)
inspect(sandisk3[2])
sandisk3<- tm_map(sandisk3, removeWords, stopwords('english'))
inspect(sandisk3[2])
sandisk3<- tm_map(sandisk3,stripWhitespace)
inspect(sandisk3[2])

tdm<- TermDocumentMatrix(sandisk3)
tdm
tdm1<- as.matrix(tdm)
tdm1
tdm1[10:20,1:5]

w<- rowSums(tdm1)
w
w_sub<- subset(w,w>25)
w_sub
barplot(w_sub,las = 2,col = rainbow(40))
library(wordcloud)
w_sub2<- sort(rowSums(tdm1),decreasing = TRUE)
wordcloud(words=names(w_sub2),freq =w_sub2)
wordcloud(words = names(w),freq =w, random.order = F, colors = rainbow(50),scale = c(3,1))


####################  twitter extraction   ################

library(readr)
tweets_billgates1 <- read_csv("tweets_billgates1.csv")
View(tweets_billgates1)

tweet<-as.character(tweets_billgates1$text)
tweet
length(tweet)

library(tm)
tweet1<- Corpus((VectorSource(tweet)))
tweet1
inspect(tweet1[2])
tweet2<- tm_map(tweet1,tolower)
inspect(tweet2[2])
tweet2<- tm_map(tweet2,removePunctuation)
tweet2<- tm_map(tweet2,removeNumbers)
inspect(tweet2[2])
tweet2<- tm_map(tweet2, removeWords, stopwords('english'))
inspect(tweet2[2])
tweet2<- tm_map(tweet2,stripWhitespace)

removeURL<- function(z)gsub('http[[:alnum:]]*','',z)
tweet2<- tm_map(tweet2,content_transformer(removeURL))
inspect(tweet2[2])

for (j in seq(tweet2)) {
  tweet2[[j]] <- gsub("/", " ", tweet2[[j]])
  tweet2[[j]] <- gsub("@", " ", tweet2[[j]])
  tweet2[[j]] <- gsub("\\|", " ", tweet2[[j]])
  tweet2[[j]] <- gsub("\u0085", " ", tweet2[[j]])
  tweet2[[j]] <- gsub("\u0092ve", " ", tweet2[[j]])  # This is an ascii character that did not translate, so it had to be removed.
}
tweet2<- tm_map(tweet2,stripWhitespace)
inspect(tweet2[2])


tdm<- TermDocumentMatrix(tweet2)
tdm
tdm1<- as.matrix(tdm)
tdm1
tdm1[10:20,1:5]

w<- rowSums(tdm1)
w
w_sub<- subset(w,w>25)
w_sub
#barplot(w_sub,las = 1,col = rainbow(40))

tweet3 <- data.frame(word=names(w_sub), freq=w_sub)   
tweet3
library(ggplot2)
p <- ggplot(tweet3 , aes(x = reorder(word, -freq), y = freq)) +
+     geom_bar(stat = "identity") + 
  +     theme(axis.text.x=element_text(angle=45, hjust=1))
p
library(wordcloud)
w_sub2<- sort(rowSums(tdm1),decreasing = TRUE)
wordcloud(words=names(w_sub2),freq =w_sub2)
wordcloud(words = names(w),freq =w, random.order = F, colors = rainbow(40),scale = c(3,1))
