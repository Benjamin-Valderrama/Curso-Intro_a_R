# Lo que vimos la clase anterior fue solo una pequeña muestra de lo que ggplot2
# puede lograr. En esta clase, nos centraremos en gráficos más avanzados y como
# personalizarlos suficiente como para una publicación o una presentación.
# Es imporante mencionar que, si bien ggplot2 y otros paquetes tienen el potencial 
# de generar gráficos dignos de admiración, no debemos ahogarnos en un vaso de agua.
# En otras palabras, puede que Photoshop, PowerPoint o Paint sean indicados para 
# cambiar detalles específicos y no necesitemos hacer TODO con código.

data = read.csv('humanos.csv')
View(data)

# Creamos nuestro gráfico vacío
p = ggplot(data=data)

# Comenzaremos con el gráfico de dispersión de la semana pasada.
p + geom_point(aes(x=Estatura, y=Masa))

# Lo primero que haremos es bastante simple: daremos un color diferente a cada
# Sexo y una figura a cada Nacionalidad. 
# SIEMPRE que queramos asignar alguna característica visual a alguna variable,
# debemos meterlo dentro de aes().
p + geom_point(aes(x=Estatura, y=Masa, col=Sexo, shape=Nacionalidad))

# Probemos agrandar los marcadores y cambiar sus colores por daltónico-amigable. 
# Además, agregaremos unidades de medidas a los ejes y pondremos la leyendo dentro
# del gráfico
p + geom_point(aes(x=Estatura, y=Masa, col=Sexo, shape=Nacionalidad), size=3) +
  scale_color_manual(values=c('orange','#0080FF','black')) +
  labs(x='Estatura (m)', y='Masa (kg)') +
  theme(legend.position=c(0.1,0.75))

# Por último, cambiaremos el tema general a algo más minimalista y guardaremos
# el gráfico con exportar.
p + geom_point(aes(x=Estatura, y=Masa, col=Sexo, shape=Nacionalidad), size=3) +
    scale_color_manual(values=c('orange','#0080FF','black')) +
    labs(x='Estatura (m)', y='Masa (kg)') +
    theme_bw() + 
    theme(legend.position=c(0.1,0.75), # estos numeros se obtienen por ensayo y error
          legend.box.background = element_rect(color='grey'),
          legend.box.margin = margin(5,5,5,5))

# Minitarea: juega con los elementos dentro de theme() para entender bien qué
# hace cada uno.

# Ahora generaremos un gráfico de barras con apariencia similar. Este mostrará 
# la frecuencia de colores de ojo separado por sexo (usando los mismos colores
# que antes).
p + geom_bar(aes(x=factor(Color.ojos), fill=Sexo))
  

# Hay varias cosas que mejorar...
# Debemos cambiar los colores, cambiar el nombre de los ejes y quizás asignarle
# nombres a las etiquetas del eje x. Luego, hacer que su apariencia sea similar 
# al gráfico anterior.
p + geom_bar(aes(x=factor(Color.ojos), fill=Sexo)) + 
  scale_fill_manual(values=c('orange','#0080FF','black')) +
  labs(x='Color de ojos', y='Frecuencia') +
  scale_x_discrete(labels = c('0'='Verde','1'='Café claro','2'='Azul','3'='Café oscuro'))+
  theme_bw() + 
  theme(legend.position=c(0.1,0.85), # estos numeros se obtienen por ensayo y error
        legend.box.background = element_rect(color='grey'),
        legend.box.margin = margin(5,5,5,5))


# ¿Cómo juntar ambos gráficos en la misma figura?
# Exiten algunos paquetes que funcionan "sobre" ggplot2 y nos permiten 
# mejorar aun más nuestros gráficos.

# Ambos gráficos tienen un diseño similar. Sería ideal poder juntarlos y exportarlos
# como una sola figura.
# la libraría 'ggpubr' tiene varias funciones útiles. Una de ellas es 'ggarrange'.
library(ggpubr)

# Primero asignamos los gráficos a variables para poder llamarlos.
puntos = p + geom_point(aes(x=Estatura, y=Masa, col=Sexo, shape=Nacionalidad), size=3) +
  scale_color_manual(values=c('orange','#0080FF','black')) +
  labs(x='Estatura (m)', y='Masa (kg)') +
  theme_bw() + 
  theme(legend.position=c(0.1,0.75),
        legend.box.background = element_rect(color='grey'),
        legend.box.margin = margin(5,5,5,5))

barras = p + geom_bar(aes(x=factor(Color.ojos), fill=Sexo)) + 
  scale_fill_manual(values=c('orange','#0080FF','black')) +
  labs(x='Color de ojos', y='Frecuencia') +
  scale_x_discrete('Color de ojos', 
                   labels = c('0'='Verde','1'='Café claro','2'='Azul','3'='Café oscuro'))+
  theme_bw() + 
  theme(legend.position=c(0.1,0.85),
        legend.box.background = element_rect(color='grey'),
        legend.box.margin = margin(5,5,5,5))

# Después los metemos a la función.
ggarrange(puntos, barras)

# Podemos jugar con el orden y tamaño de las cosas.
ggarrange(puntos, barras, nrow=2)
ggarrange(puntos, barras, ncol=2, widths=c(2,1))

# Juntemos las leyendas y pongamos una letra para poder señalarlos.
ggarrange(puntos, barras, ncol=2, widths=c(2,1), common.legend=T,
          legend='right', labels=c('A','B'),
          label.x=c(0.1,0.2), label.y=0.95)

# Minitarea:
# Utiliza la base de datos counties.RDS y genera dos gráficos, personalízalos y
# júntalos en la misma figura.

# Ahora generaremos un gráfico animado. Para esto usaremos la base de datos
# nations
nations = read.csv('nations.csv')
head(nations)

# Queremos generar un gráfico bastante complejo.
# El eje x será la tasa de nacimiento, el eje y la tasa de muerte neonatal,
# el tamaño del punto la población de ese país y el color la categoría de ingreso.

# Para el año 1990 se ve así.
ggplot(data=nations %>% filter(year==1991)) + geom_point(aes(x=birth_rate, 
                                                             y=neonat_mortal_rate, 
                                                             size=population,
                                                             col=income),
                                                         alpha=0.6)

# Arreglaremos algunas cosas primero.

# Para crear paletas propias. 
mi_paleta = colorRampPalette(c('#FDEB6B', '#D2AB51', '#C86D49','#BE4C49','#443347'))
# PROTIP: Colormind.io

# Vamos a ordenar las categorías de ingreso.
nations$income = factor(nations$income, levels=c('Low income','Lower middle income','Upper middle income','High income','Not classified'))

ggplot(data=nations %>% filter(year==1991)) + geom_point(aes(x=birth_rate, 
                                                             y=neonat_mortal_rate, 
                                                             size=population,
                                                             col=income),
                                                         alpha=0.8) +
  scale_size_continuous(breaks=c(1e7,1e8,1e9), range=c(1,15)) +
  # Colores según nuestra paleta.
  scale_color_manual(values=mi_paleta(5))+
  labs(x='Tasa de nacimiento', y='Tasa de muerte neonatal', col='Ingreso', size='Población') + 
  xlim(c(0,60)) + ylim(c(0,80)) + theme_bw()
  
# Ahora haremos lo mismo para todos los años y los juntaremos en una animación.
library(animation)

# Generamos el vector de años
años = min(nations$year):max(nations$year)

# Generamos un gif con todos los gráficos desde el primer año hasta el último y lo guardamos.
saveGIF({
  for (i in años){
    # Nota que en cada ciclo, filtramos por año = i.
    plot = ggplot(data=nations %>% filter(year==i)) + geom_point(aes(x=birth_rate, 
                                                                 y=neonat_mortal_rate, 
                                                                 size=population,
                                                                 col=income),
                                                                 alpha=0.8) +
      scale_size_continuous(breaks=c(1e7,1e8,1e9), range=c(1,15)) +
      scale_color_manual(values=mi_paleta(5))+
      # Añadimos un título que indique el año.
      labs(x='Tasa de nacimiento', y='Tasa de muerte neonatal', col='Ingreso', size='Población', title=i) + 
      xlim(c(0,60)) + ylim(c(0,80)) + theme_bw()
    print(plot)
  }
}, interval=0.1, movie.name='MiGIF.gif')


# Esto es solo el comienzo.





