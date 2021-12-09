# -*- coding: utf-8 -*-
"""
Created on Sun Jun 21 16:08:22 2020

@author: kahli
"""
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import nltk
nltk.download('maxent_ne_chunker')
!python -m nltk.downloader popular
from textblob import Word
from textblob import TextBlob
from bs4 import BeautifulSoup
import string

imdb = pd.read_csv("C:/Users/kahli/Desktop/STAT 5870/Final Project/IMDB Dataset.csv")

imdb.isna().any()

imdb.shape

reviews = imdb["review"]
reviews.head()


sns.countplot(x = "sentiment", data = imdb)
#Removing HTML tags  and punctuation from the data.
K = imdb.review

imdb["review"] = [BeautifulSoup(K).get_text() for K in imdb["review"]]
imdb["review"].head()
df_imRev = imdb["review"]




def remove_punctuation(no_punc):
   no_punc = ''.join([i for i in no_punc if i not in frozenset(string.punctuation)])
   return no_punc

rev_clean = df_imRev.apply(remove_punctuation)

rev_clean[3]

textblob_rev = TextBlob(rev_clean)


def find_pol(review):
    return TextBlob(review).sentiment.polarity

rev_clean['Sentiment_Polarity'] = rev_clean.apply(find_pol)
d_rev_clean = rev_clean.drop("Sentiment_Polarity", axis = 0)
rev_sent = rev_clean['Sentiment_Polarity']

#Count of "negative" Polarity. (#12146)
neg_count = rev_sent[(rev_sent >= -1) & (rev_sent < 0)].count()
neg = rev_sent[(rev_sent >= -1) & (rev_sent < 0)]


#Count of "positive" Polarity. (#37854)
pos_count = rev_sent[(rev_sent >= 0) & (rev_sent <= 1)].count()
pos = rev_sent[(rev_sent >= 0) & (rev_sent <= 1)]

#Made a new data frame for the cleaned reviews and sentiment polarity.
new_Rev = pd.DataFrame({"review":d_rev_clean, "Sentiment_Polarity": rev_sent})

sns.distplot(new_Rev["Sentiment_Polarity"], bins = 20)
# Since the data set has 50,000 observations I wasn't sure if you wanted use to try and tokenize or find entities all of them.
#So I only did a few observaations becasue they most of the reviews were long paragraphs.

rev3 = new_Rev["review"][3]

tokens = nltk.word_tokenize(rev3)
print(tokens)

tag = nltk.pos_tag(tokens)
print(tag)

entity1 = nltk.chunk.ne_chunk(tag)
entity1
print(entity1)



rev20000 = new_Rev["review"][20000]
rev20000

tokens2 = nltk.word_tokenize(rev20000)
print(tokens2)

tag2 = nltk.pos_tag(tokens2)
print(tag2)

entity2 = nltk.chunk.ne_chunk(tag2)
entity2
print(entity2)


rev300 = new_Rev["review"][300]
rev300

tokens3 = nltk.word_tokenize(rev300)
print(tokens3)

tag3 = nltk.pos_tag(tokens3)
print(tag3)

entity3 = nltk.chunk.ne_chunk(tag3)
entity3
print(entity3)




