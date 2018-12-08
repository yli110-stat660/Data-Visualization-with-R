#' ---
#' title: "socviz chapter 7 section 3 Statebins"
#' author: "Yaqiong Li"
#' date: "Dec 8, 2018"
#' output: pdf_document
#' ---
#' 
#' Instead of using *ggplot2* or *chloroplethr* packages to achieve chloropelth maps in the United States, *statebins* is another choice.
#' 
#' Install the book's package from github.
## ------------------------------------------------------------------------
# devtools::install_github("kjhealy/socviz")

#' 
#' Several arguements:
#' * state_data refers to the data frame
#' * state_col refers to a vector of state names
#' * value_col refers to the value to be shown
#' * statebins_continuous() refers to continuous variables
#' 
## ----message=FALSE-------------------------------------------------------
library(statebins)
library(socviz) # this package has election as a data frame
library(tidyverse)

head(election)

#' 
## ------------------------------------------------------------------------
election %>% select(state, total_vote, r_points, pct_trump, party, census) %>% sample_n(5)

#' 
## ------------------------------------------------------------------------
statebins_continuous(state_data = election, 
                     state_col = "state", 
                     text_color = "white", 
                     value_col = "pct_trump", 
                     brewer_pal = "Reds", 
                     font_size = 3, 
                     legend_title = "Percent Trump")

#' 
## ------------------------------------------------------------------------
statebins_continuous(state_data = subset(election, st %nin% "DC"), 
                     state_col = "state",
                     text_color = "black",
                     value_col = "pct_clinton",
                     brewer_pal = "Blues",
                     font_size = 3,
                     legend_title = "Percent Clinton")

#' 
#' For categorical data, use statebins_manual(). Here a variable called _color_ is created to represent the party.
## ------------------------------------------------------------------------
election <- election %>% mutate(color = recode(party, 
                                               Republican = "red",
                                               Democrat = "blue"))
head(election)

#' 
## ------------------------------------------------------------------------
statebins_manual(state_data = election,
                 state_col = "st",
                 color_col = "color",
                 text_color = "black",
                 font_size = 3,
                 legend_title = "Winner",
                 labels = c("Trump", "Clinton"),
                 legend_position = "right")

#' 
#' Alternatively, use statebins() cut the data by the _breaks_ argument.
## ------------------------------------------------------------------------
statebins(state_data = election,
          state_col = "state",
          value_col = "pct_trump",
          text_color = "white",
          breaks = 4,
          labels = c("4-21", "21-37", "37-53", "53-70"),
          brewer_pal = "Reds",
          font_size = 3,
          legend_title = "Percent Trump")

#' 
