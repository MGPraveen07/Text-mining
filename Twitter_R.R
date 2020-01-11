install.packages("twitteR")
library("twitteR")
install.packages("ROAuth")
library("ROAuth")
cred <- OAuthFactory$new(consumerKey='54KkQ0dr2efpriC3xt4EkQcHy', # Consumer Key (API Key)
                         consumerSecret='g1YYC7LoemFcxP1m74IahhTddEDuJcPquBMZAqsGwit6zZL4bK', #Consumer Secret (API Secret)
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='https://api.twitter.com/oauth/authorize')
#cred$handshake(cainfo="cacert.pem")
save(cred, file="twitter authentication.Rdata")

load("twitter authentication.Rdata")

install.packages("base64enc")
library(base64enc)

install.packages("httpuv")
library(httpuv)

setup_twitter_oauth("iqRErl0i2KOJgmhVbj4m9bZUW", # Consumer Key (API Key)
                    "zvzAuGmBBfO1k95G7LS9Vz9Wu5iirSY82E22qM6iX6bhQYjd8a", #Consumer Secret (API Secret)
                    "903527982739759104-gH7HLiELjFaa4gMCzAwI55xbAJTSpTI",  # Access Token
                    "vbQSDoUx0qxsuGJVL0GYDxxmLt2Oe6ck1NtvYfDJeFaFz")  #Access Token Secret

11#registerTwitterOAuth(cred)


Tweets <- userTimeline('billgates', n=1000)
TweetsDF <- twListToDF(Tweets)
write.csv(TweetsDF, "tweets.csv")

getwd()
Tweets <- userTimeline('Twitter page', n = 1000, cainfo="cacert.pem")
TweetsDF <- twListToDF(Tweets)
write.csv(TweetsDF, "Official Channel Tweets.csv")
#handleTweets <- searchTwitter('@TwitterHandle', n = 10000, since = '2015-04-01', cainfo="cacert.pem") 
#handleTweetsDF <- twListToDF(handleTweets)
#handleTweetsMessages <- unique(handleTweetsDF$text)
#handleTweetsMessages <- as.data.frame(handleTweetsMessages)
#write.csv(handleTweetsDF, "TefalHandleTweets.csv")