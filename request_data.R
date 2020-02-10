## Load packages ====
library(tidyverse)
library(httr)
library(jsonlite)

## Set up API headers ====
endpoint <- "api-football-v1.p.rapidapi.com/"
api_key <- Sys.getenv("api_football")

## Get French league data ====
parameters <- "v2/teams/league/4"
get_url <- str_c("https://", endpoint, parameters)
response <- GET(get_url, add_headers("x-rapidapi-host" = endpoint, 
                                     'x-rapidapi-key' = api_key))
france_data <- response %>% 
  content("text", encoding = "UTF-8") %>% 
  fromJSON() %>% 
  pluck("api", "teams")

## Get French teams data ====
teams_id <- france_data %>% pull(team_id)
# parameters <- "v2/players/team/81/2018-2019"
api_headers <- c("x-rapidapi-host" = endpoint, 'x-rapidapi-key' = api_key)
teams_data <- map(teams_id, 
                     ~str_c("https://", endpoint, "v2/players/team/", 
                            .x, "/2018-2019") %>% 
                       GET(add_headers(api_headers)) %>% 
                       content("text", encoding = "UTF-8") %>% 
                       fromJSON() %>% 
                       pluck("api", "players"))

bind_rows(teams_data)

