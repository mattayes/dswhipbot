## dswhipbot

## Step 0: Setup
setwd("~/projects/dswhipbot")
library(XLConnect)
library(twitteR)
library(stringr)

## Step 1: Create content for the bot's tweets.
## Read in (de)motivating phrases
shoutings <- readWorksheet(loadWorkbook("./dswhipbot-shoutings.xlsx"),
                           sheet = 1, header = FALSE, simplify = TRUE)
## Now some animal names
animals <- readWorksheet(loadWorkbook("./dswhipbot-animals.xlsx"),
                         sheet = 1, header = FALSE, simplify = TRUE)
## And finally some negative attributes
attributes <- readWorksheet(loadWorkbook("./dswhipbot-attributes.xlsx"),
                            sheet = 1, header = FALSE, simplify = TRUE)

## Step 2: Get connected to Twitter
## Load API info
library(twitteR)
api_key <- Sys.getenv("twitter_api_key")
api_secret <- Sys.getenv("twitter_api_secret")
access_token <- Sys.getenv("twitter_access_token")
access_token_secret <- Sys.getenv("twitter_access_token_secret")
## Connect
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

## Step 3: Make it happen
## Tweet it!
tweettxt <- toupper(str_c(sample(shoutings, 1), " ",
                          sample(attributes, 1), " ",
                          sample(animals, 1), "."
))
tweet(tweettxt)
## Log it
line <- paste(as.character(Sys.time()), tweettxt, sep="\t")
write(line, file="tweets.log", append=TRUE)