########################## MIX TEST  ##########################
set.seed(12221)
mixTest <- list(biTestVocab[sample(nrow(biTestVocab), 1000),],
                triTestVocab[sample(nrow(triTestVocab), 1000),],
                fourTestVocab[sample(nrow(fourTestVocab), 1000),],
                fiveTestVocab[sample(nrow(fiveTestVocab), 1000),])

score <- vector(mode="numeric")

for (index in 1:1000) {
  roundScore <- 0
  
  bigram <- mixTest[[1]][index,]$Pred1
  bigramAnswer <- mixTest[[1]][index,]$Predicted
  
  trigram <- paste(mixTest[[2]][index,]$Pred1, mixTest[[2]][index,]$Pred2, collapse=" ")
  trigramAnswer <- mixTest[[2]][index,]$Predicted
  
  fourgram <- paste(mixTest[[3]][index,]$Pred1, mixTest[[3]][index,]$Pred2, mixTest[[3]][index,]$Pred3, collapse=" ")
  fourgramAnswer <- mixTest[[3]][index,]$Predicted
  
  fivegram <- paste(mixTest[[4]][index,]$Pred1, mixTest[[4]][index,]$Pred2, mixTest[[4]][index,]$Pred3, mixTest[[4]][index,]$Pred4, collapse=" ")
  fivegramAnswer <- mixTest[[4]][index,]$Predicted
  
  bigramPred <- ngramPredict(bigram)
  trigramPred <- ngramPredict(trigram)
  fourgramPred <- ngramPredict(fourgram)
  fivegramPred <- ngramPredict(fivegram)
  
  if (bigramAnswer %in% bigramPred) {
    roundScore <- roundScore + 1
  }
  
  if(trigramAnswer %in% trigramPred) {
    roundScore <- roundScore + 1
  }
  
  if(fourgramAnswer %in% fourgramPred) {
    roundScore <- roundScore + 1
  }
  
  if(fivegramAnswer %in% fivegramPred) {
    roundScore <- roundScore + 1
  }
  
  score[index] <- roundScore
  roundScore <- 0
  
  print(index)
}

print(sum(score) / 4000)
print(ngramPredict("XXXX XXXXX XXX XXXXXXXX XXXXXXX XXXXX the best"))

rm(score)
rm(roundScore)
rm(index)
rm(biTestVocab)
rm(triTestVocab)
rm(fourTestVocab)
rm(fiveTestVocab)
rm(mixTest)
rm(bigram)
rm(bigramAnswer)
rm(bigramPred)
rm(trigram)
rm(trigramAnswer)
rm(trigramPred)
rm(fourgram)
rm(fourgramAnswer)
rm(fourgramPred)
rm(fivegram)
rm(fivegramAnswer)
rm(fivegramPred)
