generar_info_keynotes <- function(){
  tibble::tibble(
  name = "Dra. Hanna Frick",
  href = "https://www.frick.ws",
  img = "img/posts/hanna.jpg",
  info_es = "Hanna Frick es co-fundadora de R Ladies Global, trabaja como ingeniera de software en Posit (Ex. RStudio) en el área de modelado estadístico colaborando en el desarrollo del paquete tidymodels (conjunto de paquetes para el modelado y el aprendizaje estadístico usando los principios del paquete tidyverse. Además (https://www.frick.ws)"
) |> 
  tibble::add_row(
    name = "Dra. Dianne Cook",
    href = "http://www.dicook.org",
    img = "img/posts/dianne.jpg",
    info_es = "Dianne Cook es profesora de Business Analytics en Monash University cuyos temas de interés son la estadística computacional, visualización estadística, problemas en altas dimensiones entre otros. Es miembro del R Foundation y editora del R Journal (http://www.dicook.org)."
  ) |> 
  tibble::add_row(
    name = "Dr. Fabrizio Scrollini",
    href = "https://www.linkedin.com/in/fabrizioscrollini/",
    img = "img/posts/Fabrizio.jpg",
    info_es = "Fabrizio Scrollini es el Director para América Latina y el Caribe del Equipo Humanitario de OpenStreetMap. Cofundó la Iniciativa Latinoamericana por los Datos Abiertos (ILDA) y hoy preside su directorio. Ha explorado el uso de datos y el machine learning (IA) para el desarrollo, la transparencia y la innovación en América Latina, con particular foco en el uso de datos para el bien público. En este rol Fabrizio ha colaborado con sociedad, gobierno y academia para desarrollar iniciativas e investigaciones relevantes al contexto latinoamericano. Es uno de los asesores de la Carta Internacional de los Datos Abiertos y activo contribuyente a los temas de gobierno abierto en nuestra región."
  ) |> 
  tibble::add_row(
    name = "Dr. Max Kuhn",
    href = "https://www.rstudio.com/authors/max-kuhn/",
    img = "img/posts/Max.jpg",
    info_es = "Max Kuhn trabaja actualmente como ingeniero de software en Posit (Ex. Rstudio) liderando el desarrollo de software en el área del modelado estadístico anteriormente fue Director de área de estadística no clínica de Pfizer Global. Es autor de numerosos paquetes de R con foco en aprendizaje estadístico e investigación reproducible (https://www.rstudio.com/authors/max-kuhn/)."
  )
}

generar_card_keynote <- function(tab, col_info = "info_es"){
  bslib::card(
    full_screen = FALSE,
    bslib::card_header(tab$name, class = "card-header-keynote"),
    bslib::card_image(
      file = here::here(tab$img),
      href = tab$href,
      border_radius = "all"
    ),
    bslib::card_body(tab[[col_info]]),
  )
}


generar_cards_keynotes <-
  function(info_keynotes,
           col_information = "info_es",
           width_col = 0.5) {
    bslib::layout_column_wrap(
      class = "cards-display",
      width = width_col,
      gap = "0.5cm",
      height = 300,
      generar_card_keynote(info_keynotes[1,], col_info = col_information),
      generar_card_keynote(info_keynotes[2,],  col_info = col_information),
      generar_card_keynote(info_keynotes[3,],  col_info = col_information),
      generar_card_keynote(info_keynotes[4,],  col_info = col_information)
    )
  }
