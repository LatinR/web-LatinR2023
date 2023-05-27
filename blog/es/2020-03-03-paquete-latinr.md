---
layout: post
title:  "Paquete latinr para crear y enviar trabajos a LatinR"
isStaticPost: false
lang: es
ref: paquete-latinr
date: 2020-03-03
---

#### Presentando: latinr, el paquete

En esta edición de LatinR estrenamos una nueva forma de enviar trabajos enteramente desde la sesión de R!

La idea es facilitar lo más posible todo el proceso de creación, formato y envío de trabajos. Con el paquete latinr podrán escribir la presentación con R Markdown agregando los detalles en el header, compilar a PDF usando el estilo de la conferencia y enviarlo sin tener que llenar ningún formulario.

Es importante aclarar que usar el paquete no es obligatorio en absoluto. Quien no se sienta cómode con R Markdown puede usar cualquier herramienta que quiera para crear su PDF y quien prefiera usar la inferfaz web de EasyChair, puede hacerlo sin problema.

Una segunda aclaración es que el envío de trabajos mediante el paquete todavía es un poco experimental, por lo que les pedimos que si lo usan, vayan a la web para cerciorarse de que todo haya salido correctamente.

##### Cómo usar latinr para crear trabajos a LatinR

Lo primero de todo es, por supuesto, instalar el paquete. Esto pueden hacerlo con el comando `devtools::install_github("latinr/latinr")`.

Si usan RStudio, pueden ir a Archivo -\> Nuevo Archivo -\> R Markdown -\> Desde Plantilla y ahí seleccionar "LatinR submission article". Ahí ponen el nombre de su presentación y la carpeta dónde quieren crearla y al darle OK se les creará un archivo base que pueden empezar a completar.

Van a ver que todos los datos de envío van en el encabezado del archivo. Pueden llenarlos a mano pero más fácil es usar el "wizard" con la funcion `latinr::latinr_wizard()`. Eso les ve a llevar a una interfaz gráfica donde pueden llenar sus datos y que al final les va a mostrar un encabezado yaml válido para copiar y pegar en su archivo.

![latinr wizard](/img/posts/wizard.png)

Alternativamente pueden usar el wizard y darle al botón "Save" en la esquina superior derecha y eso les va a crear el mismo archivo base pero con los datos completados. En cualquier caso, el archivo R Markdown les va a quedar algo así:

![latinr file skeleton](/img/posts/latinr-skeleton.png)

El primer chunk del documento chequea que la metadata esté más o menos correcta cada vez que se renderiza el archivo. Recomendamos no editarlo para que cualquier error salga a la luz lo antes posible. El resto es el documento de R Markdown de prueba. Pueden tratar de "knitear" este archivo de prueba para estar seguro que su instalación de LaTeX está en orden y luego comenzar a preparar su presentación para LatinR!

##### Cómo enviar el artículo

Hasta acá latinr les permite crear un PDF con la plantilla de la conferencia y correctamente anonimizado para el envío. Pueden enviar ese PDF manualmente entrando a la página de [EasyChair](http://bit.ly/latinr2020-easychair), pero si quieren, pueden hacerlo usando latinr.

En cualquier caso, van a tener que [hacerse una cuenta en EasyChair](https://easychair.org/account/signup). Luego, tienen la opción de guardar sus datos de cuenta `latinr::latinr_password_set()`, que les va a pedir su usuario y su contraseña. Esto no es obligatorio pero facilita las cosas. Es posible que necesiten instalar el paquete keyring, en cuyo caso, les saldrá un error informativo.

Finalmente el envío se realiza con `latinr::latinr_submit()`. Por default se fija si hay un único archivo con extensión .Rmd en su directorio de trabajo y, si así es, lo toma como el archivo a enviar. Luego, les muestra los detalles del envío para asegurarse de que esté todo bien, luego renderiza y muestra el archivo PDF para también asegurarse de que haya renderizado correctamente y finalmente hace el envío.

Opcionalmente, si tienen el PDF renderizado de otro lado, pueden usar un .Rmd con el encabezado únicamente para los detalles (como el título, los nombres de les autores, etc...) y pasarle la ruta al archivo PDF que quieren enviar.

Como dijimos antes, este proceso es relativamente experimental y la integración con formularios web es siempre complicada. Por eso, es **muy importante** ir a la página de EasyChair para chequear una última vez que todos los datos se hayan cargado correctamente y que el archivo haya sido subido bien. En caso de que haya algún problema, pueden corregirlo manualmente en la página.

##### Absolutamente opcional

Cada parte de todo este proceso es completamente opcional. Pueden usar latinr para crear y enviar su trabajo, sólo para crearlo, sólo para enviarlo o no usarlo en absoluto. ¡Hagan lo que les haga sentir más cómodes!

Pero si usan latinr y encuentran algún problema o tienen alguna sugerencia, ¡no duden en contactarnos! La mejor forma es [abriendo un issue en el repositorio en GitHub](https://github.com/LatinR/latinr/issues) o mandando un mensaje en nuestro [Slack](http://bit.ly/latinr_slack), o pueden enviarle un mail al maintainer del paquete usando `packageDescription("latinr")$Maintainer`. Todo este proceso es nuevo para nosotros también y ojalá que con la comunidad podamos mejorarlo aún más!
