# Run code below when we need to update

Sys.getenv("TOKEN_JSON") |> 
  writeLines(here::here("data-raw/token.json"))


googlesheets4::gs4_auth(
  path = here::here("data-raw/token.json")
)

usethis::ui_info("Updating team....")

url_sheets_team <-
  "https://docs.google.com/spreadsheets/d/1rIBZHB4c9SGrFUz-hO2rJxWbnIvJRPKnR8cUNrzbSk4/edit#gid=928900239"

sheets_team_raw <-
  googlesheets4::read_sheet(url_sheets_team)

sheets_team_raw |>
  readr::write_rds(here::here("sobre/equipo/team.rds"))



usethis::ui_info("Updating scientific committee....")

url_sheets_comite <-
  "https://docs.google.com/spreadsheets/d/1XrOVbMh1twUpBCih7JgsSa2lg_1dhU-hNL-4IjhhcCA/"

sheets_comite_raw <-
  googlesheets4::read_sheet(url_sheets_comite, "comite_cientifico")

sheets_comite_raw |>
  readr::write_rds(here::here("sobre/equipo/comite.rds"))


usethis::ui_info("Updating program....")

url_sheets_program <-
  "https://docs.google.com/spreadsheets/d/1Qd9x7VhNkgQFf1FSDei8RFhVlVSjXwhzZx5Mxf_ySeI/edit#gid=781033699"

sheets_program_raw <-
  googlesheets4::read_sheet(url_sheets_program)

sheets_program_raw |>
  readr::write_rds(here::here("cronograma/programa/program.rds"))

# cronograma

url_sheets_cronograma <-
  "https://docs.google.com/spreadsheets/d/137-RFl2sHI8KGIyiKGgbjTTxkyTquW-C8m8_ZzQNFcw/"

sheets_cronograma_raw <-
  googlesheets4::read_sheet(url_sheets_cronograma)

sheets_cronograma_raw |>
  readr::write_rds(here::here("cronograma/programa/cronograma.rds"))

# posters 
sheets_posters_raw <-
  googlesheets4::read_sheet(url_sheets_cronograma, "posters")

sheets_posters_raw |>
  readr::write_rds(here::here("cronograma/programa/posters.rds"))

# prepared program
source(here::here("R/generar-info-program.R"))
program_complete <- import_info_program()
program_complete |>
  readr::write_rds(here::here("cronograma/programa/program_complete.rds"))
