library(tidyverse)

data = read_csv('humanos.csv')
View(data)

# Recordemos que cada columna de un data.frame es un vector y que todos los 
# elementos de un vector deben ser de la misma clase. De esta forma cada columna
# de un data.frame tiene una clase. Debemos tener presente esto al momento de 
# hacer gr�ficos. Accedemos a estas clases con la funci�n str()
str(data) 

# Gr�fico de frecuencias (el m�s com�n es barras) para variable categ�rica
frecuencias = table(data$Sexo)
barplot(frecuencias, ylim=c(0,20)) # ylim es un vector de largo 2 con el rango del eje y

# Podemos ponerle color
barplot(frecuencias, ylim=c(0,20), col=3)

# Gr�fico de frecuencias para variable num�rica
hist(data$Edad, xlab='Edad', ylab='Frecuencia', main='Soy un titulo')

h = hist(data$Edad, xlab='Edad', ylab='Frecuencia', breaks=20, col='green'); h
text(h$mids,h$counts,labels=h$counts, adj=c(0.5, -0.5))

# Gr�fico de cajas variable discreta y variable continua
boxplot(data$Estatura~data$Nacionalidad, xlab='Sexo', ylab='Estura') # el simbolo '~' en R significa "explicado por"

# Gr�fico de dispersi�n para dos variables continuas
plot(data$Estatura, data$Masa, xlab='Estatura', ylab='Masa')

# Gr�fico de frecuencias para dos variables discretas
frecuencias = table(paste(data$Sexo,data$Nacionalidad))
frecuencias_matrix = matrix(frecuencias, ncol=3)
colnames(frecuencias_matrix) = c('Hombre', 'Mujer', 'Otro')
rownames(frecuencias_matrix) = c('Argentina', 'Chilena', 'Peruana')
image(frecuencias_matrix)

# �til para estudios multivariados (gen�tica)
str(data)
data$Nombre = as.numeric(factor(data$Nombre))
data$Sexo = as.numeric(factor(data$Sexo))
data$Nacionalidad = as.numeric(factor(data$Nacionalidad))
heatmap(as.matrix(data), scale = 'col')

# Gr�fico de dispersi�n separando por colores.
plot(data$Estatura, data$Masa, xlab='Estatura', ylab='Masa', col=factor(data$Sexo), pch=20, cex=2)
legend(1.26,90,unique(data$Sexo),col=1:length(data$Sexo),pch=20)


