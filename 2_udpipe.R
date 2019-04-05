##################
# SETUP

library(tidyverse)
library(udpipe)
library(multidplyr)

# parallel processing
cluster <- create_cluster(4) %>%
  cluster_library("tidyverse") %>%
  cluster_library("udpipe")



##################
# read the data
mc_precleaned <- read_csv("mc_precleaned.csv")



##################
# download UDPipe english moel
en <- udpipe_download_model(language = "english")
udmodel_en <- udpipe_load_model(file = en$file_model)

lemma <- udpipe_annotate(udmodel_en, 
                         x = mc_precleaned$SPEECH_ACT, 
                         tagger = "default", parser = "none")

lemma <- as_tibble(lemma)
write_csv(lemma, "lemma.csv")
