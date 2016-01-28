# install.packages("mosaic")
library(mosaic)
library(Lahman)

inductees <-
  HallOfFame %>%
  group_by(playerID) %>%
  filter(votedBy %in% c("BBWAA", "Special Election") & category == "Player") %>%
  summarise(yearsOnBallot = n(), inducted = sum(inducted == "Y"), best = max(votes/ballots)) %>%
  arrange(desc(best))

batting <-
  Batting %>%
  group_by(playerID) %>%
  summarise(numSeasons = length(unique(yearID)), lastSeason = max(yearID), tH = sum(H), tHR = sum(HR)) %>%
  arrange(desc(tH))

pitching <-
  Pitching %>%
  group_by(playerID) %>%
  summarise(numSeasons = length(unique(yearID)), lastSeason = max(yearID), tW = sum(W), tSO = sum(SO), tSV = sum(SV)) %>%
  arrange(desc(tW))

awards <-
  AwardsPlayers %>%
  group_by(playerID) %>%
  summarise(mvp = sum(awardID == "Most Valuable Player"), gg = sum(awardID == "Gold Glove"), cy = sum(awardID == "Cy Young Award"))

candidates = merge(x=batting, y=pitching, by="playerID", all=TRUE)
candidates = merge(x=candidates, y=awards, by="playerID", all.x=TRUE)
candidates = merge(x=candidates, y=inductees, by="playerID")

candidates[is.na(candidates)] <- 0

require(rpart)
mod = rpart(as.factor(inducted) ~ tH + tHR + mvp + gg + tW + tSO + tSV + cy, data=candidates)

# install.packages("maptree")
require(maptree)
draw.tree(mod)
