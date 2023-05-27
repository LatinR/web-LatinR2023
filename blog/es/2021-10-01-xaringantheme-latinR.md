---
layout: post
title:  "Creando presentaciones con el theme latinR"
isStaticPost: false
date: 2021-10-01
lang: es
ref: call-for-papers-pkg
---

#### El theme latinR

Es un placer compartir el nuevo theme de xaringan **latinR**. El theme latinR permite crear presentaciones usando el paquete de R xaringan, con un estilo particular para esta conferencia.

#### Instalación

Para utilizar el theme latinR, primero asegúrate de tener instalado el paquete [xaringan](https://cran.r-project.org/web/packages/xaringan/index.html); además, necesitarás descargar el archivo [latinR.css](https://github.com/LatinR/xaringan_latinR/blob/master/latinR.css) desde nuestro [repositorio](https://github.com/LatinR/xaringan_latinR) de GitHub.

#### Generando una nueva presentación

Ahora, genera una nueva presentación de xaringan en tu sesión de R o RStudio desde:

File \> New File \> R Markdown \> From Template \> Ninja Presentation

Coloca el archivo latinR.css en la misma ubicación que tu archivo .Rmd de la presentación.

Agrega la linea css: \["latinR.css"\] en el yaml de la presentación:

```         
---
title: "Título de tu presentación"
author: "Tu nombre"
output:
  xaringan::moon_reader:
    css: ["latinR.css"]
---
```

#### Usando el template.Rmd

Si lo deseas, puedes usar el [template](https://github.com/LatinR/xaringan_latinR/blob/master/template.Rmd) de presentación de LatinR, disponible en nuestro [repositorio](https://github.com/LatinR/xaringan_latinR) de GitHub.

Para visualizar la presentación, puedes utilizar la función inf_mr() del paquete xaringan o utilizar el botón Knit de RStudio.

#### Diapositivas del theme latinR

El theme latinR incluye una diapositiva de título:

![Diapositiva de título, incluida en el theme latinR. Se muestra una diapositiva con el color de fondo gris usado en el logo de LatinR. Se muestra el logo de LatinR en la esquina superior izquierda, que incluye una representación del mapa de latinoamérica y la frase 'LATINR Conferencia Latinoamericana sobre el uso de R en Investigación y Desarrollo'. En el cuerpo de la diapositiva se muestra el texto centrado en color negro 'Título de tu presentación \n usando xaringan \n Tu nombre \n LatinR 2021 \n 10-12 de noviembre de 2021'](/img/posts/title_slide.png)

<br>

Diapositivas de contenido:

![Diapositiva de contenido, incluida en el theme latinR. Se muestra una diapositiva con color de fondo blanco y tres niveles de encabezado en color morado. El texto de la diapositiva es 'Header 1: Agrega algo de texto aquí. Header 2: Agrega algo de texto aquí. Header 3: Chunk de código en R con el texto Agrega tu código seq(1:5)'](/img/posts/body_slide.png)

<br>

Y una diapositiva para separar por capítulos la presentación:

![Diapositiva de capítulo, incluida en el theme latinR. Se muestra una diapositiva con el color de fondo morado usado en el logo de LatinR y letras en color blanco con la frase 'Capítulo nuevo'](/img/posts/chapter_slide.png)

<br>

Si deseas incluir gráficos generados con ggplot2, te sugerimos utilizar escalas de color amigables con las personas con dificultades visuales; por ejemplo, la escala viridis.

![Diapositiva de ejemplo mostrando el uso de la escala viridis para generar gráficas con colores amigables. Se muestran gráficas de densidad con los datos de la masa corporal de pinguinos de las especies Adelie, Chinstrap y Gentoo del conjunto de datos pinguinos del paquete en español datos separados por color de acuerdo con la especie, con ayuda de la escala viridis. En la columna izquierda se están utilizando los colores morado, esmeralda y amarillo. En la columna derecha se muestra la simulación de cómo se vería la gráfica de la izquierda considerando cuatro deficiencias visuales: Deutanomalía,Protanomalía, Tritanomalía y Desaturado](/img/posts/viridis.png)

<br>

#### Texto Alternativo

Adicionalmente, te animamos a utilizar el texto alternativo para describir el contenido de las imágenes en la presentación. Si estás usando nuestro template o cualquier archivo .Rmd, puedes utilizar la opción fig.alt del chunk de R.

Puedes ver una presentación ejemplo generada con xaringan y el theme latinR en el siguiente [link](https://latinr.github.io/xaringan_latinR/template.html)
