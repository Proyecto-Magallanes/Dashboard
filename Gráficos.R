
rm(list=ls())
#install.packages("writexl")

library(haven)
library(dplyr)
library(writexl)
library(readxl)
library(ggplot2)

# Reemplaza 'ruta_del_archivo' con la ubicación completa del archivo DTA en tu sistema
ruta_del_archivo <- "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/embarazo.dta"

# Cargar el archivo DTA en un objeto de datos en R
embarazo <- haven::read_dta(ruta_del_archivo)

# Utiliza la función rename para cambiar el nombre de la columna
embarazo<- embarazo%>%rename(Departamento = V023)

# Crear un vector con los nombres de los departamentos
nombres_departamentos <- c(
  "Amazonas", "Ancash", "Apurimac", "Arequipa", "Ayacucho", "Cajamarca", "Callao", "Cusco", "Huancavelica",
  "Huanuco", "Ica", "Junin", "La_Libertad", "Lambayeque", "Lima", "Loreto", "Madre_de_Dios", "Moquegua",
  "Pasco", "Piura", "Puno", "San_Martin", "Tacna", "Tumbes", "Ucayali"
)

# Reemplazar los valores numéricos por los nombres de departamentos
embarazo$Departamento <- nombres_departamentos[embarazo$Departamento]

# Grpafico de barras de la tasa de embarazos

# Cargar la biblioteca dplyr para manipulación de datos
library(dplyr)

# Cargar la biblioteca dplyr para manipulación de datos
library(dplyr)

# Convertir la columna 'Departamento' a un factor
embarazo$Departamento <- factor(embarazo$Departamento)

# Ordenar el DataFrame por la columna 'embara' de menor a mayor
embarazo <- embarazo %>%
  arrange(embara)

# Crear el gráfico de barras horizontal con barras verdes claras
library(ggplot2)
barras <- ggplot(data = embarazo, aes(x = reorder(Departamento, embara), y = embara)) +
  geom_bar(stat = "identity", fill = "lightgreen") +
  
  # Configurar etiquetas y título
  labs(x = "Departamentos",
       y = "Tasa de Embarazos",
       title = "Tasa de Embarazos por Departamento (2021)") +
  
  # Establecer el tamaño del gráfico
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()

saveRDS(barras, file = "barras.rds")

# -------------------------------------------------
# Cargar la biblioteca dplyr para manipulación de datos
library(dplyr)

# Convertir las columnas 'Departamento' a factores
embarazo$Departamento <- factor(embarazo$Departamento)
deserci$Departamento <- factor(deserci$Departamento)

# Ordenar el DataFrame de embarazos por la columna 'embara' de menor a mayor
embarazo <- embarazo %>%
  arrange(embara)

# Crear el gráfico de barras horizontal con etiquetas dentro de las barras y pie de página
barras2 <- ggplot(data = embarazo, aes(x = reorder(Departamento, -embara), y = embara)) +
  geom_bar(stat = "identity", fill = "lightgreen") +
  geom_text(aes(label = sprintf("%.2f", embara), vjust = 0.5), hjust = -0.1, size = 3) +
  
  # Configurar etiquetas, título y pie de página
  labs(x = "Departamentos",
       y = "Tasa de Embarazos") +
  
  # Configurar el pie de página a la izquierda
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0)) +  # Ajustar el valor de hjust
  
  coord_flip()

  # Agregar el pie de página
  barras2 <- barras + labs(caption = "Fuente: Encuesta Nacional de Hogares (ENAHO)\nElaboración Propia")
  barras2

saveRDS(barras2, file = "barras2.rds")
#--------


# Crear el gráfico de puntos para la tasa de deserción (como antes)
# Crear el gráfico de puntos para la tasa de deserción con etiquetas y dos decimales
# Crear el gráfico de puntos para la tasa de deserción
puntos <- ggplot(data = deserci, aes(x = reorder(Departamento, -deser), y = deser)) +
  geom_point(color = "blue") +
  labs(x = "Departamentos",
       y = "Tasa de Deserción") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14))

puntos

saveRDS(puntos, file = "puntos")
#----
# Crear el gráfico de puntos para la tasa de deserción (como antes)
puntos <- ggplot(data = deserci, aes(x = reorder(Departamento, -deser), y = deser)) +
  geom_point(color = "blue") +
  labs(x = "Departamentos",
       y = "Tasa de Deserción",
      ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()
puntos
saveRDS(puntos, file = "puntos.rds")
# -----------------
# Cargar la biblioteca dplyr para manipulación de datos
library(dplyr)

# Convertir las columnas 'Departamento' a factores
embarazo$Departamento <- factor(embarazo$Departamento)
deserci$Departamento <- factor(deserci$Departamento)

# Ordenar el DataFrame de embarazos por la columna 'embara' de menor a mayor
embarazo <- embarazo %>%
  arrange(embara)

# Crear el gráfico de barras horizontal con etiquetas dentro de las barras
barras2 <- ggplot(data = embarazo, aes(x = reorder(Departamento, -embara), y = embara)) +
  geom_bar(stat = "identity", fill = "lightgreen") +
  geom_text(aes(label = sprintf("%.2f", embara), vjust = 0.5), hjust = -0.1, size = 3) +
  
  # Configurar etiquetas y título
  labs(x = "Departamentos",
       y = "Tasa de Embarazos") +
  
  # Configurar el pie de página a la izquierda
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

barras2


#-----

# Cargar la biblioteca dplyr para manipulación de datos
library(dplyr)

# Convertir las columnas 'Departamento' a factores
embarazo$Departamento <- factor(embarazo$Departamento)
deserci$Departamento <- factor(deserci$Departamento)

# Ordenar el DataFrame de embarazos por la columna 'embara' de menor a mayor
embarazo <- embarazo %>%
  arrange(embara)

# Crear el gráfico de barras horizontal con etiquetas en las barras
barras <- ggplot(data = embarazo, aes(x = reorder(Departamento, -embara), y = embara)) +
  geom_bar(stat = "identity", fill = "lightgreen") +
  geom_text(aes(label = sprintf("%.2f", embara)), hjust = -0.1, vjust = 0.5, size = 3) +
  
  # Configurar etiquetas y título
  labs(x = "Departamentos",
       y = "Tasa de Embarazos",
       title = "Tasa de Embarazos por Departamento (2021)") +
  
  # Establecer el tamaño del gráfico
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()

# Crear el gráfico de puntos para la tasa de deserción (como antes)
puntos <- ggplot(data = deserci, aes(x = reorder(Departamento, -deser), y = deser)) +
  geom_point(color = "blue") +
  labs(x = "Departamentos",
       y = "Tasa de Deserción",
       title = "Tasa de Deserción por Departamento (2021)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()

# Combinar ambos gráficos en uno solo
library(gridExtra)
combinado <- grid.arrange(barras, puntos, ncol = 2)

# Guardar el gráfico combinado con el nombre "barras_puntos.png" (o el formato deseado)
ggsave("barras_puntos.png", plot = combinado, width = 12, height = 6)












# Guardar el gráfico combinado con el nombre "barras_puntos.png" (o el formato deseado)
ggsave("barras_puntos.png", plot = combinado, width = 12, height = 6)

# Cargar la biblioteca dplyr para manipulación de datos
library(dplyr)
library(ggplot2)

# Convertir las columnas 'Departamento' a factores
embarazo$Departamento <- factor(embarazo$Departamento)
deserci$Departamento <- factor(deserci$Departamento)

# Ordenar el DataFrame de embarazos por la columna 'embara' de menor a mayor
embarazo <- embarazo %>%
  arrange(embara)

# Crear el gráfico de barras horizontal con barras verdes claras
library(ggplot2)
barras <- ggplot(data = embarazo, aes(x = reorder(Departamento, embara), y = embara)) +
  geom_bar(stat = "identity", fill = "lightgreen") +
  
# Configurar etiquetas y título
  labs(x = "Departamentos",
       y = "Tasa de Embarazos",
       title = "Tasa de Embarazos por Departamento (2021)") +
  
# Establecer el tamaño del gráfico
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()

# Crear el gráfico de puntos para la tasa de deserción
puntos <- ggplot(data = deserci, aes(x = reorder(Departamento, -deser), y = deser)) +
  geom_point(color = "blue") +
  labs(x = "Departamentos",
       y = "Tasa de Deserción",
       title = "Tasa de Deserción por Departamento (2021)") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()

# Combinar ambos gráficos en uno solo
library(gridExtra)
combinado <- grid.arrange(barras, puntos, ncol = 2)

# Guardar el gráfico combinado con el nombre "barras_puntos.png" (o el formato deseado)
ggsave("barras_puntos.png", plot = combinado, width = 12, height = 6)








# Reemplaza 'ruta_del_archivo' con la ubicación completa del archivo DTA en tu sistema
ruta2 <- "C:/Users/MISHELL/Documents/desercion.dta"
# Cargar el archivo DTA en un objeto de datos en R
deserci <- haven::read_dta(ruta2)

#-------
setwd("C:/Users/MISHELL/Documents")

# Especifica el nombre del archivo Excel que deseas abrir
nombre_archivo_excel <- "desercion.xlsx"

# Abre el archivo Excel y guarda los datos en el DataFrame "desercion"
desercion <- read_excel(nombre_archivo_excel)

# Especifica el nombre del archivo DTA en el que deseas guardar los datos
nombre_archivo_dta <- "desercion.dta"

# Guarda los datos del DataFrame "desercion" en formato DTA
write_dta(desercion, nombre_archivo_dta)


#--------

# Realizar la unión después de la conversión
datos <- inner_join(embarazo, deserci, by = "Departamento")


# Calcular la correlación entre las tasas de embarazo y deserción
correlacion <- cor(datos$embara, datos$deser)

# Imprimir el valor de correlación
print(paste("Correlación entre tasas de embarazo y deserción:", correlacion))

# Interpretación
if (correlacion > 0) {
  mensaje <- "Existe una correlación positiva entre las tasas de embarazo y deserción."
} else if (correlacion < 0) {
  mensaje <- "Existe una correlación negativa entre las tasas de embarazo y deserción."
} else {
  mensaje <- "No hay una correlación significativa entre las tasas de embarazo y deserción."
}

print(mensaje)
# [1] "Existe una correlación positiva entre 
#     las tasas de embarazo y deserción."


# Graficar la correlación entre las variables "embara" y "erci"
plot(datos$embara, datos$deserci, main = "Correlación entre embara y erci", 
     xlab = "embara", ylab = "desercion")








