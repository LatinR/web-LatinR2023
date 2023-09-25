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
