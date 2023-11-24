/* LIMPIANDO BASE DE DATOSS

V213 --> actualmente embarazada

*/

 clear all
 cd "C:\Users\MISHELL\Desktop\2. Proyecto Magallanes\Dashboard\data"

* Año 2021
 use RE223132-2022, clear
 use embarazo-2022, clear
 merge 1:1 CASEID using "REC0111-2022", nogen 
 merge m:1 HHID using "RECH23-2022", nogen
 
 *Cambio del nombre
 label variable V023 "Departamento"
 label define dpto 1 "Amazonas" 2 "Ancash" 3 "Apurimac" 4 "Arequipa" 5 "Ayacucho" ///
 6 "Cajamarca"  7 "Callao" 8 "Cusco" 9 "Huancavelica" 10 "Huanuco" 11 "Ica" 12 "Junin" ///
 13 "La_Libertad" 14 "Lambayeque"  15 "Lima" 16 "Loreto" 17 "Madre_de_Dios" 18 "Moquegua" ///
 19 "Pasco" 20 "Piura" 21 "Puno" 22 "San_Martin" 23 "Tacna" 24 "Tumbes" 25 "Ucayali"
 
 *Keep para edades
 keep if V013 ==1 // keep para edades 15-19
 * V213 // actualmente embarazada
 * V023 // departamentos
 * V219 // Número total de hijos vivos incluido el embarazo actual
 * V219 == 1 - Embarazadas o madres por 1era vez
   
 * Factor de extensión
 gen factor=V005/1000000
 tab V213 V013 [iweight=factor], col nofreq 

*----------------------------------------------------------------------------- 
*Embarazo por primera vez 
 gen emba = V213 & V219==1 
 tab V023 emba [iweight=factor], row nofreq 
 
 * Sumar la variable emba ponderada por factor
 collapse emba [aweight = factor], by(V023)
 
 * Calcular el porcentaje ponderado
 gen embara= emba * 100
 keep V023 embara
 
 /* Crear el gráfico de barras
 graph bar (asis) emba, over(V023) percentage ///
    ytitle("Departamentos") xtitle("Porcentaje de Embarazadas") ///
    legend(off) title("Porcentaje de Embarazadas por Departamento")
	*/
 save embarazo-2022, replace

*----------------------------------------------------------------------------- 
*Matrimonio Infantil 
 
 *ENAHO
 use RE516171-2021, clear
 merge 1:1 CASEID using "REC0111-2021", nogen 
 gen factor=V005/1000000
 tab V023 V511 [iweight=factor], row nofreq 
 gen matri1 = (V511 <= 18)
 tab V023 matri1 [iweight=factor], row nofreq 
 
 * Sumar la variable emba ponderada por factor
 collapse matri1 [aweight = factor], by(V023)

  * Calcular el porcentaje ponderado
 gen matri_in= matri1 * 100
 keep V023 matri_in
 save matrimonio, replace

 /* RENIEC
 import excel using "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/BD_Pob_Identificada_2021_Xls.xlsx", firstrow clear
 rename UBIGEO_R UBIGEO
 save "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/BD_Pob_Identificada_2021_Xls.xlsx/BD_Pob_Identificada_2021_Xls.dta", replace

cd "C:\Users\MISHELL\Desktop\2. Proyecto Magallanes\Dashboard\data\"
append using "Bd_matrimonios_2021_Excel.xlsx"

 
 import excel using "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/Bd_matrimonios_2021_Excel.xlsx", firstrow clear
 use "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/Bd_matrimonios_2021_Excel.xlsx", clear

 merge 1:1 UBIGEO using "BD_Pob_Identificada_2021_Xls.xlsx", nogen 

 import excel using "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/BD_Pob_Identificada_2021_Xls.xlsx", firstrow clear
 gen año=2021
 
 * RENIEC.2
 import excel using "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/BD_Pob_Identificada_2021_Xls.xlsx", firstrow clear
 save "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/BD_Pob_Identificada_2021_Xls.dta", replace
 
 import excel using "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/Bd_matrimonios_2021_Excel.xlsx", firstrow clear
 save "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/Bd_matrimonios_2021.dta", replace
 
 use BD_Pob_Identificada_2021_Xls, clear
 rename UBIGEO_R UBIGEO
 keep if Edad >= 11
 keep if Residencia == "Nacional"
 drop Residencia UBIGEO_INEI Continente CodPais Pais
 
 use Bd_matrimonios_2021, clear
 keep UBIGEO DEPA_CONT PROV_PAIS DIST_CIUD CANTIDAD
 rename DEPA_CONT Departamento
 rename PROV_PAIS Provincia
 rename DIST_CIUD Distrito
 rename CANTIDAD matrimonios
 save Bd_matrimonios_2021, replace
 
 merge 1:m UBIGEO Departamento Provincia Distrito using "Bd_matrimonios_2021", nogen
 
 merge 1:1 UBIGEO Departamento Provincia Distrito using "ruta_de_segunda_base\segunda_base.dta", nogen
*/

*-----------------------------------------------------------------------------  
* Tasa de Deserción
  import excel using "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/tasa de deserción-2002-2022.xlsx", firstrow clear
  save "C:/Users/MISHELL/Desktop/2. Proyecto Magallanes/Dashboard/data/tasa_de_desercion.dta", replace
  
  use tasa_de_desercion.dta, clear

 *-----------------------------------------------------------------------------  

 
 * Maternidad
 * V213
 
* Año 2022
 use RE223132, clear
 merge 1:1 CASEID using "REC0111", nogen 

 * keep if V213==1 // keep de embarazadas
 
 tab V213 V023
 codebook V013
 
* keep if V013 ==1| V013 ==0 // keep para edades 12-14 y 15-19
 keep if V013 ==1 // keep para edades 15-19
 
 * si hago el keep de edades no tengo q hacer el keep de embarazadas para sacar el % de total de muejres de 15 a 19 años embarazadas o nogen
 
 tab V213 V013, col nofreq // col = columna porcentaje , row = filas
 
// factor de expansión

gen factor=V005/1000000

tab V213 V013 [iweight=factor], col nofreq 
 
 * por edades % de mujeres de 15 a 19 años 

 * V023 // departamentos
 
 tab V023 V213, row nofreq
 
 
save limpieza, replace // guardado en la base de datos

