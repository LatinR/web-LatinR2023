extract_people <- function(list_team) {
  list_team |>
    purrr::pluck("people") |>
    purrr::map(\(x) purrr::map_at(x, "social", list)) |>
    purrr::map(tibble::as_tibble) |>
    purrr::list_rbind(names_to = "id_yaml") |>
    tidyr:::nest(titles = titles,
                 .by = c(id_yaml:surname, social)) |>
    dplyr::mutate(social = purrr::map(social, parse_social)) |>
    tidyr::unnest(titles) |>
    dplyr::mutate(titles = paste0("- ", titles),
                  titles = dplyr::if_else(titles %in% c("- NA", "NA") | is.na(titles), "", titles)) |> 
    tidyr::unnest(social, names_sep = "_") |>
    dplyr::select(-social_name) |>
    tidyr::pivot_wider(
      id_cols = c(id_yaml, id, name, surname, titles),
      names_from = social_type,
      values_from = social_link
    ) |> 
    dplyr::mutate(name_complete = glue::glue("{name} {surname}")) |> 
    generate_icons()
  
}

parse_social <- function(x) {
  x |> 
    tibble::enframe() |> 
    tidyr::unnest(value) |> 
    tidyr::unnest(value) |> 
    dplyr::group_by(name) |> 
    dplyr::summarise(
      type = value[1],
      link = value[2]
    )
}


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
  #   readr::write_rds("sobre/equipo/comite.rds")
  
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