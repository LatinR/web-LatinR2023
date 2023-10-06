library(lubridate)
library(googlesheets4)
library(janitor)
library(toastui)
library(dplyr)

gs4_deauth()

#### PROGRAMA ----

### GET TALKS INFORMATION
datos <- read_sheet(Sys.getenv("LATINR_SCHEDULE"))

data <-datos %>% 
  janitor::clean_names() %>% 
  dplyr::select(title = titulo_presentacion, 
                tags = palabras_clave,
                body = resumen_breve, 
                author = nombre_6)


#### CREAT sim DATA (classroms, timetable, etc)
calendarId <- c(rep(c("Aula 1","Aula 2","Aula 3"), 18), "Aula 1", "Aula 3")


start_day <-  lubridate::as_datetime('2023-10-18 09:00:00')  %>% 
  force_tz("America/Montevideo")



start <-c(seq(ymd_hm('2023-10-19 10:00'),ymd_hm('2023-10-19 12:30'), by = '25 mins'),
          seq(ymd_hm('2023-10-19 14:00'),ymd_hm('2023-10-19 17:30'), by = '25 mins')) %>% 
  force_tz("America/Montevideo")

end <- as_tibble(start) %>% 
  mutate(value = value + lubridate::minutes('25')) %>% 
  pull()  %>% 
  force_tz("America/Montevideo")

### CREATE DATA SUBSETS x Classroom

aula1 <- data %>% 
  filter(calendarId == 'Aula 1') %>% 
  slice(1:16) %>% 
  cbind(start, end)  %>% 
  as_tibble()  %>% 
  mutate(calendarId = "1")


aula2 <- data %>% 
  filter(calendarId == 'Aula 2') %>% 
  slice(1:16) %>% 
  cbind(start, end) %>% 
  as_tibble() %>% 
  mutate(calendarId = "2")

aula3 <- data %>% 
  filter(calendarId == 'Aula 3') %>% 
  slice(1:16) %>% 
  cbind(start, end)  %>% 
  as_tibble() %>% 
  mutate(calendarId = "3")


#### TUTORIALS ----

tutorials <- tibble(title  = c("Dra. Hannah Frick & Dr. Max Kuhn: Introduction to Machine Learning with tidymodels (I)",
                               "Dra. Hannah Frick & Dr. Max Kuhn: Introduction to Machine Learning with tidymodels (II)"), 
                    tags = c('Models - Part 1',
                             'Models - Part 2'), 
                    body = c("This workshop provides an 
                             introduction to machine learning with R using the tidymodels framework,
                             a collection of packages for modeling and machine learning using tidyverse principles. 
                             We will build, evaluate, and compare predictive models. 
                             Along the way, we’ll learn about key concepts in machine learning including overfitting 
                             and resampling. Learners will gain knowledge about good predictive modeling practices, 
                             as well as hands-on experience using tidymodels packages like parsnip, rsample, yardstick, 
                             and workflows.",
                             "Dra. Hannah Frick & Dr. Max Kuhn. This workshop provides an 
                             introduction to machine learning with R using the tidymodels framework,
                             a collection of packages for modeling and machine learning using tidyverse principles. 
                             We will build, evaluate, and compare predictive models. 
                             Along the way, we’ll learn about key concepts in machine learning including overfitting 
                             and resampling. Learners will gain knowledge about good predictive modeling practices, 
                             as well as hands-on experience using tidymodels packages like parsnip, rsample, yardstick, 
                             and workflows."), 
                    start =  c(ymd_hm('2023-10-18 09:30') %>% force_tz("America/Montevideo"),
                               ymd_hm('2023-10-18 13:30') %>% force_tz("America/Montevideo")), 
                    end = c(ymd_hm('2023-10-18 12:30') %>% force_tz("America/Montevideo"),
                            ymd_hm('2023-10-18 17:00') %>% force_tz("America/Montevideo")), 
                    calendarId = c('tutorial',
                                   'tutorial'))   %>% 
  tibble::add_row(title = "Toby Dylan Hocking: Using and contributing to the data.table package for efficient big data analysis", 
                     tags = 'data.table', 
                     body = 'data.table is one of the most efficient open-source in-memory data manipulation packages available today. 
                     First released to CRAN by Matt Dowle in 2006, it continues to grow in popularity, and now over 1400 other CRAN packages 
                     depend on data.table. This three hour tutorial will start with data reading from CSV, discuss basic and advanced data 
                     manipulation topics, and finally will end with a discussion about how you can contribute to data.table. 
                     In each part of the tutorial, you will be asked to solve a few exercises, to practice each new concept.', 
                     start = ymd_hm('2023-10-18 9:00') %>% force_tz("America/Montevideo"),
                     end = ymd_hm('2023-10-18 12:30') %>% force_tz("America/Montevideo"), 
                     calendarId = 'tutorial') %>% 
  tibble::add_row(title = "Dra. Dianne Cook: Creating data plots for effective decision-making using statistical inference with R", 
                  tags = 'data plots for inference', 
                  body = 'data.table is one of the most efficient open-source in-memory data manipulation packages available today. 
                     First released to CRAN by Matt Dowle in 2006, it continues to grow in popularity, and now over 1400 other CRAN packages 
                     depend on data.table. This three hour tutorial will start with data reading from CSV, discuss basic and advanced data 
                     manipulation topics, and finally will end with a discussion about how you can contribute to data.table. 
                     In each part of the tutorial, you will be asked to solve a few exercises, to practice each new concept.', 
                  start = ymd_hm('2023-10-18 13:30') %>% force_tz("America/Montevideo"),
                  end = ymd_hm('2023-10-18 17:00') %>% force_tz("America/Montevideo"), 
                  calendarId = 'tutorial') %>% 
  tibble::add_row(title = "Riva Quiroga: Creación de reportes reproducibles con Quarto", 
                  tags = 'quarto', 
                  body = 'En este tutorial se hará una introducción a [Quarto](https://quarto.org/), un sistema de publicación científica y técnica que permite crear contenido dinámico usando R, Python, Julia y Observable. Durante la sesión se abordarán los aspectos generales de su uso para crear reportes con R, con especial énfasis en el trabajo en formato HTML. Para ello, se mostrará paso a paso cómo crear un reporte reproducible, cómo parametrizar su contenido, cómo editar su apariencia y cómo publicarlo utilizando GitHub Pages y Netlify.
Para poder seguir sin problema las actividades del tutorial, es necesario tener algún grado de experiencia  con el operador "pipe" (en cualquiera de sus dos versiones: %>% o |>), con las funciones principales del paquete dplyr (como filter, summarize y group_by) y con el paquete ggplot2 (por ejemplo, tener una idea general de qué hacen las funciones geom_* o saber cómo modificar la escala del eje "y" de un gráfico). Para quienes tengan interés en la publicación de un reporte utilizando el servicio GitHub Pages, es necesario tener al menos un 
                  manejo inicial de git (saber cómo hacer commits y enviar cambios a un repositorio personal)', 
                  start = ymd_hm('2023-10-18 13:30') %>% force_tz("America/Montevideo"),
                  end = ymd_hm('2023-10-18 17:00') %>% force_tz("America/Montevideo"), 
                  calendarId = 'tutorial') %>% 
  tibble::add_row(title = "Agustin Perez Santangelo, Oriol Senan y Federico Rivadeneira: Introducción a Shiny - Buenas prácticas en un entorno de producción", 
                  tags = 'shiny', 
                  body = 'El tutorial consistirá en la introducción de conceptos básicos haciendo foco en las buenas prácticas de desarrollo. El mismo constará de tres partes:

- Estructura inicial y básica de un proyecto junto a las herramientas que podemos utilizar para asistirnos en esta tarea.

- Modularización y buenas prácticas de desarrollo haciendo hincapié en conceptos de desarrollo con ejemplos.

- Optimización y performance de una aplicación introduciendo paquetes y buenas prácticas.', 
                  start = ymd_hm('2023-10-18 09:00') %>% force_tz("America/Montevideo"),
                  end = ymd_hm('2023-10-18 12:30') %>% force_tz("America/Montevideo"), 
                  calendarId = 'tutorial') 





# CELANDAR INIT ####

calendar(defaultDate = start_day,
         view = 'day', 
         navigation = TRUE, 
         navOpts = navigation_options(
           today_label = "Hoy",
           class = "bttn-stretch bttn-sm bttn-warning",
           color = "blue", 
           fmt_date = format("DD/MM/YYYY"),
           sep_date = "-"
         )) %>% 
  cal_timezone(displayLabel = 'UTC-3', # CALENDAR SETTINGS
               timezoneName = 'America/Montevideo') %>% 
  cal_week_options(daynames = c("Dom", "Lun", "Mar", 
                                "Mier", "Jue", "Vie", "Sab"), hourStart = 10, hourEnd = 18
  ) %>% 
  cal_schedules(tutorials) %>% 
  cal_props(id = 'tutorial', 
            name = "TUTORIAL",
            color = "white",
            borderColor = "#B5D4EB", 
            backgroundColor = "#4c3ceb") %>% 
  cal_schedules(aula1) %>% # CREATE Independent Schedule 4 each classrom
  cal_props(id = '1', 
            name = "Aula 1",
            color = "black",
            backgroundColor = "#B5D4EB", 
            borderColor = "#4c3ceb") %>% 
  
  cal_schedules(aula2) %>% 
  cal_props(id = '2',
            name = "Aula 2",
            color = "black",
            backgroundColor = "#BEAED47A", 
            borderColor = "#4c3ceb") %>% 
  
  cal_schedules(aula3) %>% 
  cal_props(id = '3',
            name = "Aula 3",
            color = "black",
            backgroundColor = "#FDC08666", 
            borderColor = "#4c3ceb")
