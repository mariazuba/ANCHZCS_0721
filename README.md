
# INFORME FINAL ANCHOVETA CENTRO-SUR 

## Descripción del contenido del repositorio "ANCHZCS_0721"

### 1. Archivos

+ INFORMEFINAL_ANCH_julio2021.Rmd y pdf = corresponde al informe final que debe ser enviado a SUBDECON

+ FigyTab_InformeFinal_Anch.Rmd y pdf = genera las figuras y tablas que serán incorporadas en "INFORMEFINAL_ANCH_julio2021"

+ DatosEntrada.dat = contiene los datos utilizados en las figuras de sección de antecedentes y metodología del "INFORMEFINAL_ANCH_julio2021"

+ ANEXO_I_AnalisisUpdate.Rmd y pdf = Anexo I que contiene el análisis de sensibilidad de la actualización de datos de la asesoría de julio 2021.

+ FigyTab_ANEXO_I_AnalisisUpdate.Rmd y pdf = genera las figuras y tablas que serán incorporadas en "ANEXO_I_AnalisisUpdate".

+ AnalisisSensibilidad.Rmd y pdf = contiene los análisis presentados en la 4ta sesión del CCT-PP de julio 2021 y los cuales serán incorporados en ANEXO II de este informe.

+ FigyTab_paraF55_Anch.Rmd y pdf = genera las figuras y tablas para *escenario alternativo de PBRs BD50 y F55%

### 2. Carpetas

#### Tablas

+ indicadoresPoblacionales.csv = Tabla 17. Variables poblacionales estimadas en la evaluación de septiembre 2020, marzo y julio 2021 de anchoveta de las Regiones de Valparaíso a Los Lagos.
+ diferenciasVarPobl.csv = diferencias entre estimaciones últimos años con períodos previos
+ PBRs.csv = Tabla 18. Puntos biológicos de referencia de biomasa (miles t) estimados en la evaluación de stock de septiembre 2020, marzo y julio 2021 para anchoveta de las Regiones de Valparaíso a Los Lagos, calculados siguiendo los pasos descritos en la metodología de este informe.
+ indicesReduccion.csv = Tabla 19. Comparación de los índices de reducción de F respecto de FRMS (F/FRMS), BD respecto de BDRMS (BD/BDRMS) estimados en la asesoría de septiembre 2020, marzo y julio 2021 de anchoveta de las Regiones de Valparaíso a Los Lagos.
+ tasaExplotacion.csv = Tabla 20. Comparación de las tasas de explotación anual referidos a la biomasa (Y/BT) y a la abundancia estimada (C#/N#), estimadas en la evaluación de septiembre 2020, marzo y julio 2021 de anchoveta de las Regiones de Valparaíso a Los Lagos.
+ ProbabilidadesEstatus.csv = Tabla 21. Puntos Biológicos de referencia (PBRs) y probabilidades de estar bajo BDRMS y sobre FRMS y en sobreexplotación, colapsado o sobrepesca.
+ CBAinicial.csv = Tabla 22. CBA inicial 2021 de anchoveta centro-sur bajo Fcte = FRMS con sus respectivos percentiles de probabilidad entre 10 % y 50 % y tres escenarios de reclutamiento. Tabla 23. Resguardo de la Captura al RMS. Tabla 24. CBA 2021 menos el 2 %descarte. *CBA máxima recomendada por el CCT-PP = 210.167 t.
+ 1eraRevisionCBA = Tabla 25. Primera revisión de CBA 2021 de anchoveta centro-sur bajo Fcte = FRMS con sus respectivos percentiles de probabilidad entre 10 % y 50 % y tres escenarios de reclutamiento. Tabla 26. Resguardo de la Captura al RMS. Tabla 27. CBA 2021 menos el 2 %descarte
+ 2daRevisionCBA = Tabla 29. Segunda revisión de CBA 2021 de anchoveta centro-sur bajo Fcte = FRMS con sus respectivos percentiles de probabilidad entre 10 % y 50 % y tres escenarios de reclutamiento. Tabla 30. Resguardo de la Captura al RMS. Tabla 31. CBA 2021 menos el 2 %descarte.

#### Figuras

#### Funciones

+ Fn_CBA.R
+ Fn_DiagramaFase_proy.R
+ Fn_DiagramaFase2.R
+ Fn_Estatus_proy.R
+ Fn_PBRs.R
+ Fn_ProbEstatus_proy.R
+ Fn_Retrospectivo.R
+ Fn_Verosimilitud.R
+ functions.R

#### codigos_admb

+ MAE0721b (asesoría julio 2021)
+ MAE0321b (asesoría marzo 2021)
+ MAE0920b (asesoría septiembre 2020)
+ MAE0721b55 *escenario alternativo de PBRs BD50 y F55%
#### Retrospectivos, Verosimilitud, CBA y proyección

+ Retrospectivo_jul (MAE0721b)

+ Retrospectivo_marz (MAE0321b)

+ Retrospectivo_sept (MAE0920b)

+ Verosimilitud_jul (MAE0721b)

+ Verosimilitud_marz (MAE0321b)

+ Verosimilitud_sept (MAE0920b)

+ CBA_julio (MAE0721b)

+ CBA_marzo (MAE0321b)

+ CBA_sept (MAE0920b)

+ CBA_julio55 (MAE0721b55) *escenario alternativo de PBRs BD50 y F55%

#### Datos_2020_2021

+ BD senapesca 2000-2020.xlsx
+ Biomasa y Abundancia a la talla sardina común y anchoveta - RECLAS Mayo 2021.xlsx
+ CSur añoAnchoveta 20_21.xlsx
+ Estructura de talla scomun_anchov ene-jun 2021 (preliminar).xlsx
+ Informe Avance MPDH Centro Sur 2020.pdf
+ pesos iniciales anchoveta_julio2021.xlsx
+ TABLA_Comp-abundancia crucero reclas 21-05_MariaJosé.xlsx

### 3. ANEXOS

#### 3.1. Sensibilidad_update (ANEXO I)

Esta carpeta contiene los archivos .dat y .rep necesarios para generar las figuras y tablas que van contenidas en:

+ "ANEXO_I_AnalisisUpdate.Rmd" y
+ "FigyTab_ANEXO_I_AnalisisUpdate.Rmd"

##### 3.1.1. Datos actualizados a junio 2021

Descarte en año biológico 2017/18, 2018/19 y 2019/20

Desembarques 2020/21

Composición de edad de la flota 2020/21

Pesos medios e iniciales a la edad 2020/21

Biomasa crucero acústico de otoño 2021

Composición de edad del crucero acústico de otoño 2021

Tamaño de muestra

#### 3.2. Sensibilidad_mph (ANEXO II)

Esta carpeta contiene los archivos .dat y .rep necesarios para generar las figuras y tablas que van contenidas en:

+ "ANEXO_II_AnalisisSensibilidad_CVsyMPDHyCapt.Rmd" 


#### 3.3. Procedimiento Transitorio de incorporación del descarte (ANEXO III)

Análisis realizado para Documento técnico de abril 2021.

+ "ANEXO_III_ProcedimientoDescarte.Rmd"

### 4. PORTADAS

- PORTADA_INICIAL.tex y pdf
- PORTADA_ANEXO_I.tex y pdf
- PORTADA_ANEXO_II.tex y pdf
- PORTADA_ANEXO_III.tex y pdf
- PORTADA_FINAL.tex y pdf

### 5. SUBDECON_julio2021

- BASEDATOS_ANCH_JULIO2021.zip
- FORMULARIO FAI_TERCERINFORME_ANCHOVETA.docx
- TERCERINFORMECONSOLIDADO_ANCHOVETACENTROSUR_JULIO2021.pdf



