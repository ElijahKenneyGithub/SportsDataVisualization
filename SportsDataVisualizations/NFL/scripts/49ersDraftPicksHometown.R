install.packages("tidyverse")
install.packages("nflverse")
install.packages("leaflet")
library(tidyverse)
library(nflverse)
library(cfbfastR)
library(leaflet)

player_info <- nflreadr::load_rosters(2024)



sf_player_info <- player_info %>%
         #Filter players from SF 
           filter(
            team == "SF"
           )
            

# In college football rosters, I believe the home latitude and longitude are there, we shall check this, just taking all of the data from 2019 to now. 
cfb_player_info_2024 <- cfbfastR::cfbd_draft_picks(year = 2024, nfl_team = "San Francisco")
cfb_player_info_2023 <- cfbfastR::cfbd_draft_picks(year = 2023, nfl_team = "San Francisco")
cfb_player_info_2022 <- cfbfastR::cfbd_draft_picks(year = 2022, nfl_team = "San Francisco")
cfb_player_info_2021 <- cfbfastR::cfbd_draft_picks(year = 2021, nfl_team = "San Francisco")
cfb_player_info_2020 <- cfbfastR::cfbd_draft_picks(year = 2020, nfl_team = "San Francisco")
cfb_player_info_2019 <- cfbfastR::cfbd_draft_picks(year = 2019, nfl_team = "San Francisco")

# Joining the data from all years to get a complete picture

combined_data <- bind_rows(cfb_player_info_2024, cfb_player_info_2023, cfb_player_info_2022, cfb_player_info_2021, cfb_player_info_2020, cfb_player_info_2019) 

# Quick cleaning, noticing some NAs
combined_data <- drop_na(combined_data)

#Renaming the two columns for location for leaflet to recognize | Commented because I already ran this code for the combined_data set.
combined_data <- combined_data %>%
     rename(lng = hometown_info_longitude) %>%
      rename(lat = hometown_info_latitude)

combined_data <- combined_data %>%
       mutate(
         lat = as.numeric(lat),
         lng = as.numeric(lng)
       )

leaflet() %>%
   addTiles() %>%
   addCircleMarkers(data = combined_data, color = "red",  popup = ~paste("Player:", name, "<br>", "Team:", nfl_team))
   