##################
# SETUP

library(tidyverse)
library(multidplyr)

# parallel processing
cluster <- create_cluster(4) %>%
    cluster_library("tidyverse")


 
##################
# remove punctuation, all text to lowercase

raw <- read_delim("membercontributions-20181210.tsv", 
                  "\t", escape_double = FALSE, trim_ws = TRUE)

raw2 <- raw %>%
  as_tibble() %>%
  mutate(BILL = str_remove_all(BILL, "[:punct:]"),
         BILL = tolower(BILL),
         MEMBER = str_remove_all(MEMBER, "[:punct:]"),
         MEMBER = tolower(MEMBER),
         SPEECH_ACT = str_remove_all(SPEECH_ACT, "[:punct:]"),
         SPEECH_ACT = tolower(SPEECH_ACT)
  )

write_csv(raw2, "mc_precleaned.csv")
