import_info_program <- function(){
  
  sheets_program_raw <- readr::read_rds(here::here("cronograma/programa/program.rds"))
  
  sheets_cronograma_raw <- readr::read_rds(here::here("cronograma/programa/cronograma.rds"))
  
  sheets_posters_raw <- readr::read_rds(here::here("cronograma/programa/posters.rds"))
  
  
  
  
  data <- sheets_program_raw |>
    janitor::clean_names()  |>
    dplyr::rename(title = titulo_presentacion,
                  tags = palabras_clave,
                  body = resumen_breve,
                  # author 1
                  author_name_1 = nombre_6,
                  author_website_1 = sitio_web_7,
                  author_github_1 = git_hub_8,
                  author_linkedin_1 = linked_in_9,
                  author_mastodon_1 = mastodon_10,
                  author_twitter_1 = twitter_11,
                  # author 2
                  author_name_2 = nombre_13,
                  author_website_2 = sitio_web_14,
                  author_github_2 = git_hub_15,
                  author_linkedin_2 = linked_in_16,
                  author_mastodon_2 = mastodon_17,
                  author_twitter_2 = twitter_18,
                  # author 3
                  author_name_3 = nombre_20,
                  author_website_3 = sitio_web_21,
                  author_github_3 = git_hub_22,
                  author_linkedin_3 = linked_in_23,
                  author_mastodon_3 = mastodon_24,
                  author_twitter_3 = twitter_25,
                  # author 4
                  author_name_4 = nombre_27,
                  author_website_4 = sitio_web_28,
                  author_github_4 = git_hub_29,
                  author_linkedin_4 = linked_in_30,
                  author_mastodon_4 = mastodon_31,
                  author_twitter_4 = twitter_32,
                  # author 5
                  author_name_5 = nombre_34,
                  author_website_5 = sitio_web_35,
                  author_github_5 = git_hub_36,
                  author_linkedin_5 = linked_in_37,
                  author_mastodon_5 = mastodon_38,
                  author_twitter_5 = twitter_39,
                  # author 6
                  author_name_6 = nombre_41,
                  author_website_6 = sitio_web_42,
                  author_github_6 = git_hub_43,
                  author_linkedin_6 = linked_in_44,
                  author_mastodon_6 = mastodon_45,
                  author_twitter_6 = twitter_46,
                  # author 7
                  author_name_7 = nombre_48,
                  author_website_7 = sitio_web_49,
                  author_github_7 = git_hub_50,
                  author_linkedin_7 = linked_in_51,
                  author_mastodon_7 = mastodon_52,
                  author_twitter_7 = twitter_53,
                  
                  # author 8
                  author_name_8 = nombre_55,
                  author_website_8 = sitio_web_56,
                  author_github_8 = git_hub_57,
                  author_linkedin_8 = linked_in_58,
                  author_mastodon_8 = mastodon_59,
                  author_twitter_8 = twitter_60,
                  
                  # author 9
                  author_name_9 = nombre_62,
                  author_website_9 = sitio_web_63,
                  author_github_9 = git_hub_64,
                  author_linkedin_9 = linked_in_65,
                  author_mastodon_9 = mastodon_66,
                  author_twitter_9 = twitter_67,
                  
                  # author 10
                  author_name_10 = nombre_69,
                  author_website_10 = sitio_web_70,
                  author_github_10 = git_hub_71,
                  author_linkedin_10 = linked_in_72,
                  author_mastodon_10 = mastodon_73,
                  author_twitter_10 = twitter_74,
                  # author 11
                  author_name_11 = nombre_76,
                  author_website_11 = sitio_web_77,
                  author_github_11 = git_hub_78,
                  author_linkedin_11 = linked_in_79,
                  author_mastodon_11 = mastodon_80,
                  author_twitter_11 = twitter_81,
                  # author 12
                  author_name_12 = nombre_83,
                  author_website_12 = sitio_web_84,
                  author_github_12 = git_hub_85,
                  author_linkedin_12 = linked_in_86,
                  author_mastodon_12 = mastodon_87,
                  author_twitter_12 = twitter_88,
                  ) |> 
    dplyr::select(-tidyselect::starts_with("necesitas_agregar_mas_autores_"),
                  -marca_temporal)
  
  data_prepared <- data |> 
    tibble::rowid_to_column() |> 
    tidyr::pivot_longer(cols = tidyselect::starts_with("author_")) |> 
    tidyr::drop_na(value) |> 
    dplyr::mutate(number_author = stringr::str_extract(name, "[0-9]$")) |> 
    dplyr::mutate(value2 = dplyr::case_when(
      stringr::str_detect(name, "author_name_") ~ stringr::str_to_title(value),
      stringr::str_detect(name, "author_github_") ~ glue::glue('<a href="{value}" target="_blank"><i class="fab fa-github"></i></a>'),
      stringr::str_detect(name, "author_website_") ~ glue::glue('<a href="{value}" target="_blank"><i class="fas fa-home"></i></a>'),
      stringr::str_detect(name, "author_linkedin_") ~ glue::glue('<a href="{value}" target="_blank"><i class="fab fa-linkedin"></i></a>'),
      stringr::str_detect(name, "author_twitter_") ~ glue::glue('<a href="{value}" target="_blank"><i class="fab fa-twitter"></i></a>'),
      stringr::str_detect(name, "author_mastodon_") ~ glue::glue('<a href="{value}" target="_blank"><i class="fab fa-mastodon"></i></a>'),
    )) |> 
    dplyr::group_by(
      rowid, numero_propuesta_en_open_review,
      title, tags, body, number_author
    ) |> 
    dplyr::summarise(
      author_text = paste0(value2, collapse = " ")
    ) |> 
    dplyr::ungroup() |> 
    dplyr::group_by(
      rowid, numero_propuesta_en_open_review,
      title, tags, body
    ) |> 
    dplyr::summarise(
      author = paste0(author_text, collapse = " <br>")
    ) |> 
    dplyr::ungroup() |> 
    dplyr::select(-rowid) |> 
    dplyr::rename(id = numero_propuesta_en_open_review) 
  
 sheets_cronograma <- sheets_cronograma_raw |> 
    tidyr::drop_na(id)
 
 charlas <- sheets_cronograma |> 
   dplyr::filter(sesion == "charlas") |> 
   dplyr::left_join(data_prepared, by = dplyr::join_by(id)) |> 
   dplyr::select(-title) |> 
   dplyr::rename(title = titulo) |> 
   dplyr::mutate(
     date = dplyr::case_when(
       dia == "jueves" ~ "2023-10-19",
       dia == "viernes" ~ "2023-10-20"
     ),
     hora = lubridate::hour(hora_inicio),
     minuto = lubridate::minute(hora_inicio)
   ) |> 
   dplyr::arrange(hora, minuto) |> 
   dplyr::mutate(conteudo = glue::glue("
                                     <b>Titulo:</b>  <span style='color:#002495;'><b>{title}</b></span><br><br>
                                     <b>Authors:</b> <br>{author}<br>
                                     <b>Tema:</b> {tema}<br>
                                     <b>Lugar:</b> {lugar}<br>
                                     <b>Hora:</b> {hora}:{minuto}<br>
                                     <b>Descripción:</b> {body}<br><hr>
                                     ")) 
 
 posters <- sheets_posters_raw |> 
   dplyr::left_join(data_prepared, by = dplyr::join_by(id)) |> 
   dplyr::select(-title) |> 
   dplyr::rename(title = titulo) |> 
   dplyr::mutate(conteudo = glue::glue("
                                     <b>Titulo:</b>  <span style='color:#002495;'><b>{title}</b></span><br>
                                     <b>Authors:</b> <br>{author}<br>
                                     <b>Descripción:</b> {body}<br><hr>
                                     ")) 
 
 
 list(
   charlas = charlas,
   posters = posters
 )
 
}
