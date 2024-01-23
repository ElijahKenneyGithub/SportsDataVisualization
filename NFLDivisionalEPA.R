
install.packages("nflfastR")
library(nflfastR)
install.packages("tidyverse") 
library(tidyverse)

library(nflplotR)

library(dplyr)

# Install or reinstall the nflplotR package
install.packages("nflplotR", dependencies = TRUE)

# Replace 'game_id' with the actual Game ID of the Green Bay Packers vs San Francisco 49ers divisional game


# Load the play-by-play data
data <- load_player_stats(2023)

brock_purdy_stats_for_divisional <- filter(data, player_display_name == "Brock Purdy", week == 20)

jared_goff_stats_for_divisional <- filter(data, player_display_name == "Jared Goff", week == 20) 
mahomes_stats_for_divisional <- filter(data, player_display_name == "Patrick Mahomes", week == 20) 
lamar_jackson_stats_for_divisional <-filter(data, player_display_name == "Lamar Jackson", week == 20) 

combined_stats <- bind_rows(
  mutate(jared_goff_stats_for_divisional, player_display_name = "Jared Goff"),
  mutate(brock_purdy_stats_for_divisional, player_display_name = "Brock Purdy"),
  mutate(mahomes_stats_for_divisional, player_display_name == "Patrick Mahomes"),
  mutate(lamar_jackson_stats_for_divisional, player_display_name == "Lamar Jackson")
)




ggplot(combined_stats, aes(x = rushing_epa, y = passing_epa)) +
  nflplotR::geom_nfl_headshots(aes(player_gsis = player_id), width = 0.075, vjust = 0.5) +
  labs(
    title = "2023 Divisional NFL Quarterback EPA per Play",
    x = "Rushing EPA",
    y = "Passing EPA"
  ) +
  ggplot2::theme_minimal() +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
  )


