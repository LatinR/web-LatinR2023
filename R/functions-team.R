
generate_card <- function(person, class_group = "card-header-team") {
  bslib::card(
    full_screen = FALSE,
    bslib::card_header(person$name_complete[1], htmltools::HTML(person$icons[1]), class = class_group),
    bslib::card_body(htmltools::HTML(paste0(person$titles, collapse =  "<br> ")),
    )
  )
}

get_info_committe <- function(){
  # Run code below when we need to update
  # url_sheets_comite <- "https://docs.google.com/spreadsheets/d/1XrOVbMh1twUpBCih7JgsSa2lg_1dhU-hNL-4IjhhcCA/"
  # 
  # sheets_comite_raw <-
  #   googlesheets4::read_sheet(url_sheets_comite, "comite_cientifico")
  # 
  # sheets_comite_raw |>
  #   readr::write_rds(here::here("sobre/equipo/comite.rds"))
  
  sheets_comite_raw <- readr::read_rds(here::here("sobre/equipo/comite.rds"))
  
  sheets_comite <- sheets_comite_raw |> 
    janitor::clean_names() |> 
    dplyr::arrange(nombre) |> 
    dplyr::rename(
      name_complete = nombre,
      titles = afiliacion_institucional,
      site = sitio_web,
      github = git_hub,
      linkedin = linked_in
    ) |> 
    dplyr::select(-marca_temporal) |> 
    generate_icons()
  
  sheets_comite
}

get_info_team <- function(){
  # Run code below when we need to update
  # url_sheets_team <- "https://docs.google.com/spreadsheets/d/1rIBZHB4c9SGrFUz-hO2rJxWbnIvJRPKnR8cUNrzbSk4/edit#gid=928900239"

  # sheets_team_raw <-
  #   googlesheets4::read_sheet(url_sheets_team)
  # 
  # sheets_team_raw |>
  #   readr::write_rds(here::here("sobre/equipo/team.rds"))
  
  sheets_team_raw <- readr::read_rds(here::here("sobre/equipo/team.rds"))
  
  sheets_team <- sheets_team_raw |> 
    janitor::clean_names() |> 
    dplyr::rename(
      name_complete = 2,
      titles = 3,
      site = sitio_web,
      github = git_hub,
      linkedin = linked_in
    ) |> 
    dplyr::arrange(name_complete) |> 
    dplyr::select(-marca_temporal, -redes_sociales) |>
    dplyr::mutate(
      linkedin = fix_social_url(linkedin, "https://linkedin.com/in/"),
      github = fix_social_url(github, "https://github.com/"),
      twitter =  fix_social_url(twitter, "https://twitter.com/")
    ) |> 
    tidyr::drop_na(name_complete) |> 
    generate_icons()
  
  sheets_team
}


fix_social_url <- function(var, url_base) {
  dplyr::case_when(
    stringr::str_starts(var, "http") ~ var,
    is.na(var) ~ NA_character_,
    TRUE ~ paste0(url_base, var)
  )
}



generate_icons <- function(tab){
  tab |>
    dplyr::mutate(
      site = stringr::str_trim(site),
      icon_github = dplyr::case_when(
        !is.na(github) ~ glue::glue(
          '<a href="{github}" target="_blank"><i class="fab fa-github"></i></a>'
        ),
        TRUE ~ ""
      ) ,
      
      icon_twitter = dplyr::case_when(
        !is.na(twitter) ~ glue::glue(
          '<a href="{twitter}" target="_blank"><i class="fab fa-twitter"></i></a>'
        ),
        TRUE ~ ""
      ) ,
      
      icon_linkedin = dplyr::case_when(
        !is.na(linkedin) ~ glue::glue(
          '<a href="{linkedin}" target="_blank"><i class="fab fa-linkedin"></i></a>'
        ),
        TRUE ~ ""
      ) ,
      
      icon_mastodon = dplyr::case_when(
        !is.na(mastodon) ~ glue::glue(
          '<a href="{mastodon}" target="_blank"><i class="fab fa-mastodon"></i></a>'
        ),
        TRUE ~ ""
      ) ,
      
      icon_site = dplyr::case_when(
        !is.na(site) ~ glue::glue(
          '<a href="{site}" target="_blank"><i class="fas fa-home"></i></a>'
        ),
        TRUE ~ ""
      ) ,
      icons = glue::glue("{icon_site} {icon_github} {icon_linkedin} {icon_mastodon} {icon_twitter}",)
    )
}
