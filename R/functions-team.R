extract_people <- function(list_team){
  list_team |> 
    purrr::pluck("people") |> 
    purrr::map(\(x) purrr::map_at(x, "social", list)) |> 
    purrr::map(tibble::as_tibble) |> 
    purrr::list_rbind(names_to = "id_yaml") |> 
    tidyr:::nest(
      titles = titles, 
      .by = c(id_yaml:surname, social)
    ) |> 
    dplyr::mutate(social = purrr::map(social, parse_social))
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


generate_card <- function(person) {
  bslib::card(
    full_screen = FALSE,
    bslib::card_header(person$name_complete[1], htmltools::HTML(person$icons[1]), class = "card-header-chairs"),
    bslib::card_body(htmltools::HTML(paste0(person$titles, collapse =  "<br> ")),
    )
  )
}