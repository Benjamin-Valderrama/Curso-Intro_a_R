# Desafio

# Construye una funcion que imprima un mensaje indicando el valor minimo y 
# maximo de un vector entregado. Ademas, debe retornar estos dos valores en forma de vector.

min_max <- function(vector){
        
        minimo<- min(vector)
        maximo<- max(vector)
        
        resultado<- paste("el resultado minimo es: ", minimo, "el resultado maximo es: ", maximo)
        
        return(resultado)
}

min_max(1:14)

# Construye una funcion que reciba un vector y devuelva la moda si sus elementos
# son de tipo "character" y la media si sus elementos son de tipo "numeric"

f2<- function(vector){
        # Si son de tipo caracter
        if(is.character(vector)){
                # moda
                output<- names(which.max(table(vector)))
        } else if (is.numeric(vector)){
        # Si son de tipo numeric
                # media
                output<- mean(vector)
        } else {
                output<- "Solo recibo character y numeric"
        }
        return(output)
  
}

f2(vector)

# Construye una funcion que retorne un valor booleano (TRUE o FALSE) dependiendo
# si un numero es primo o no. Recordemos que un numero es primo si solo si es 
# divisible de forma entera por 1 y si mismo. De esta forma, 2, 3 y 5 son numeros 
# primos

f3<- function(numero){
        # Si el numero es 2, es primo
        if(numero == 2){
                output<- T
        } else if(any(numero %% 2:(numero-1) == 0)){
                # No es primo si se puede dividir por un numero entre 2 y numero-1 
                output<- F
        } else {
                # En cualquier otro caso, el numero es primo
                output<- T
        }
        return(output)
}

# Solución 2

primes= c(1:50)
library(matlab)
isprime(primes) #1 significa que es primo y 0 que no es primo

numeroprimo= c()
es_o_no_primo = function(x){
        for(nump in primes){
                if(isprime(nump)==1){
                        numeroprimo= c(numeroprimo, TRUE)
                }else{numeroprimo= c(numeroprimo, FALSE)}
                return(numeroprimo)
        }
}


es_o_no_primo(primes)


