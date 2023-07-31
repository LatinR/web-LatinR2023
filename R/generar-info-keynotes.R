generar_info_keynotes <- function(){
  tibble::tibble(
    name = "Dra. Dianne Cook",
    href = "http://www.dicook.org",
    img = "img/posts/dianne.jpg",
    info_es = "Dianne Cook es profesora de Business Analytics en Monash University. Sus principales temas de interés son la estadística computacional y la visualización estadística, particularmente la visualización de datos de alta dimensionalidad. Es miembro del R Foundation y editora del R Journal (http://www.dicook.org).",
    info_pt = "Dianne Cook é professora de Business Analytics na Universidade de Monash, cujos interesses de pesquisa incluem estatística computacional, visualização estatística, problemas em alta dimensão, entre outros. Ela é membro da Fundação R e atua como editora do R Journal (http://www.dicook.org).",
    info_en = "Dianne Cook is a Professor of Business Analytics at Monash University, whose research interests include computational statistics, statistical visualization, high-dimensional problems, among others. She is a member of the R Foundation and serves as an editor for the R Journal (http://www.dicook.org)."
    ) |> 
  tibble::add_row(
  name = "Dra. Hannah Frick",
  href = "https://www.frick.ws",
  img = "img/posts/hannah.jpg",
  info_es = "Hannah Frick es co-fundadora de R Ladies Global, trabaja como ingeniera de software en Posit (ex RStudio) en el área de modelado estadístico. Colabora en el desarrollo de tidymodels, el conjunto de paquetes para modelado y aprendizaje estadístico inspirado en los principios del Tidyverse (https://www.frick.ws).",
  info_pt = "Hannah Frick é co-fundadora do R Ladies Global e trabalha como engenheira de software na Posit (anteriormente RStudio) na área de modelagem estatística, colaborando no desenvolvimento do pacote tidymodels (um conjunto de pacotes para modelagem e aprendizado estatístico usando os princípios do pacote tidyverse) (https://www.frick.ws). ",
  info_en = "Hannah Frick is a co-founder of R Ladies Global and works as a software engineer at Posit (formerly RStudio) in the field of statistical modeling, collaborating on the development of the tidymodels package (a set of packages for modeling and statistical learning using the principles of the tidyverse package) (https://www.frick.ws). "
) |> 
  tibble::add_row(
    name = "Dr. Fabrizio Scrollini",
    href = "https://www.linkedin.com/in/fabrizioscrollini/",
    img = "img/posts/Fabrizio.jpg",
    info_es = "Fabrizio Scrollini es el Director para América Latina y el Caribe del Equipo Humanitario de OpenStreetMap. Cofundó la Iniciativa Latinoamericana por los Datos Abiertos (ILDA) y hoy preside su directorio. Ha explorado el uso de datos y el machine learning (IA) para el desarrollo, la transparencia y la innovación en América Latina, con particular foco en el uso de datos para el bien público. En este rol Fabrizio ha colaborado con sociedad, gobierno y academia para desarrollar iniciativas e investigaciones relevantes al contexto latinoamericano. Es uno de los asesores de la Carta Internacional de los Datos Abiertos y activo contribuyente a los temas de gobierno abierto en nuestra región.",
    info_pt = "Fabrizio Scrollini é o Diretor para a América Latina e o Caribe na Equipe Humanitária do OpenStreetMap (Equipo Humanitario de OpenStreetMap). Ele co-fundou a Iniciativa Latino-Americana por Dados Abertos (Iniciativa Latinoamericana por los Datos Abiertos - ILDA) e atualmente preside seu conselho. Ele explorou o uso de dados e aprendizado de máquina (IA) para desenvolvimento, transparência e inovação na América Latina, com foco especial no uso de dados para o bem público. Nesse papel, Fabrizio colaborou com a sociedade civil, governos e academia para desenvolver iniciativas e pesquisas relevantes para o contexto latino-americano. Ele é um dos consultores da Carta Internacional de Dados Abertos (Carta Internacional de los Datos Abiertos) e contribui ativamente para tópicos de governo aberto em nossa região.",
    info_en = "Fabrizio Scrollini is the Director for Latin America and the Caribbean at the Humanitarian OpenStreetMap Team (Equipo Humanitario de OpenStreetMap). He co-founded the Latin American Open Data Initiative (Iniciativa Latinoamericana por los Datos Abiertos - ILDA) and currently serves as its board chair. He has explored the use of data and machine learning (AI) for development, transparency, and innovation in Latin America, with a particular focus on using data for the public good. In his role, Fabrizio has collaborated with civil society, government, and academia to develop relevant initiatives and research in the Latin American context. He is one of the advisors to the International Open Data Charter (Carta Internacional de los Datos Abiertos) and actively contributes to open government topics in our region."
  ) |> 
  tibble::add_row(
    name = "Dr. Max Kuhn",
    href = "https://www.rstudio.com/authors/max-kuhn/",
    img = "img/posts/Max.jpg",
    info_es = "Max Kuhn trabaja como ingeniero de software en Posit (ex RStudio) liderando el desarrollo de software en el área del modelado estadístico. Anteriormente fue Director del área de estadística no clínica de Pfizer Global. Es autor de numerosos paquetes de R con foco en aprendizaje estadístico e investigación reproducible (https://www.rstudio.com/authors/max-kuhn/).",
    info_pt = "Max Kuhn atualmente trabalha como engenheiro de software na Posit (anteriormente RStudio), liderando o desenvolvimento de software na área de modelagem estatística. Anteriormente, ele atuou como Diretor de Estatística Não Clínica na Pfizer Global. Ele é autor de inúmeros pacotes R com foco em aprendizado estatístico e pesquisa reprodutível (https://www.rstudio.com/authors/max-kuhn/).",
    info_en = "Max Kuhn currently works as a software engineer at Posit (formerly RStudio), leading software development in the field of statistical modeling. He previously served as the Director of Nonclinical Statistics at Pfizer Global. He is the author of numerous R packages with a focus on statistical learning and reproducible research (https://www.rstudio.com/authors/max-kuhn/)."
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
