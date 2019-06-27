(defrule Menu

         =>
        (printout t "Hola. Bienvenido al sistema experto para la selección de personal docente universitario." crlf)
        (printout t crlf "Tenga en cuenta que si usted tiene más de un pregrado, debe ejecutar el sistema las veces necesarias teniendo como base cada uno de ellos." crlf)
        (printout t crlf "Pulse 1 para iniciar el sistema experto." crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion 1) then (assert (inicia_ejecucion_de_arbol))
        else (printout t "No ha pulsado 1. Vuelva a iniciar el sistema" crlf)
        )
)

(defrule Inicia_ejecucion_de_arbol
        (inicia_ejecucion_de_arbol)
         =>
        (do-for-all-facts ((?f initial-fact)) TRUE (retract ?f))
        (printout t "A continuación se le mostrarán varias preguntas." crlf)
        (printout t "Responda SI (en mayúscula) para responder afirmativamente y NO (en mayúscula) para responder negativamente." crlf)
        (printout t "Si tiene alguna duda en cualquier punto de la ejecución respecto a una pregunta o algo que se le muestre, puede escribir AYUDA (en mayúscula) y se le brindará orientación." crlf)
        (printout t crlf "¿Desea empezar con las preguntas?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (lengua))
        else (printout t "Su respuesta no fue SI, esto indica que no desea empezar con las preguntas." crlf)
        )
)

(defrule Recorrido
        (recorrido)
         =>
        (do-for-all-facts ((?f opcion_menu)) TRUE (retract ?f))
        (do-for-all-facts ((?f recorrido)) TRUE (retract ?f))
        (printout t crlf "Este fue su recorrido en el árbol de decisiones:" crlf)
        (facts)
        (printout t crlf "Muchas gracias por usar nuestro sistema experto." crlf crlf)
)

(defrule Finaliza_ejecucion_de_arbol
        (finaliza_ejecucion_de_arbol)
         =>
        (printout t crlf"¿Desea ver su recorrido en el árbol de decisiones?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then
            (assert (recorrido))
        else
            (if (eq ?opcion NO) then
                (printout t "Gracias por usar nuestro servicio." crlf)
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule No_es_apto_para_ningun_cargo
        (no_es_apto_para_ningun_cargo)
         =>
        (printout t "Usted no es apto para ningún cargo disponible actualmente." crlf)
        (assert (finaliza_ejecucion_de_arbol))
)

(defrule Lengua
        (lengua)
         =>
        (printout t "¿Habla una segunda lengua certificada?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_hablar_segunda_lengua)) 
        else
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_hablar_segunda_lengua))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_hablar_segunda_lengua
        (cumple_requisito_de_hablar_segunda_lengua)
         =>
        (do-for-all-facts ((?f lengua)) TRUE (retract ?f))
        (assert (pregrado))
)

(defrule No_cumple_requisito_de_hablar_segunda_lengua
        (no_cumple_requisito_de_hablar_segunda_lengua)
         =>
        (do-for-all-facts ((?f lengua)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)


(defrule Pregrado
        (pregrado)
         =>
        (printout t "¿Tiene pregrado?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_pregrado)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_es_apto_para_ningun_cargo))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_pregrado
        (cumple_requisito_de_tener_pregrado)
         =>
        (do-for-all-facts ((?f pregrado)) TRUE (retract ?f))
        (assert (posgrado))
)

(defrule No_cumple_requisito_de_tener_pregrado
        (no_cumple_requisito_de_tener_pregrado)
         =>
        (do-for-all-facts ((?f pregrado)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)


(defrule Posgrado
        (posgrado)
         =>
        (printout t "¿Tiene posgrado?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_posgrado)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_posgrado))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_posgrado
        (cumple_requisito_de_tener_posgrado)
         =>
        (do-for-all-facts ((?f posgrado)) TRUE (retract ?f))
        (assert (prederecho))
)

(defrule No_cumple_requisito_de_tener_posgrado
        (no_cumple_requisito_de_tener_posgrado)
         =>
        (do-for-all-facts ((?f posgrado)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)



(defrule Prederecho
        (prederecho)
         =>
        (printout t "¿Tiene pregrado en derecho?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (tiene_pregrado_en_derecho)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_tiene_pregrado_en_derecho))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Tiene_pregrado_en_derecho
        (tiene_pregrado_en_derecho)
         =>
        (do-for-all-facts ((?f prederecho)) TRUE (retract ?f))
        (assert (posderecho))
)

(defrule No_tiene_pregrado_en_derecho
        (no_tiene_pregrado_en_derecho)
         =>
        (do-for-all-facts ((?f prederecho)) TRUE (retract ?f))
        (assert (prediseno))
)

(defrule Posderecho
        (posderecho)
         =>
        (printout t "¿Tiene posgrado en derecho?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_posgrado_en_derecho)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_posgrado_en_derecho))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_posgrado_en_derecho
        (cumple_requisito_de_tener_posgrado_en_derecho)
         =>
        (do-for-all-facts ((?f posderecho)) TRUE (retract ?f))
        (assert (expdocenciaderecho))
)

(defrule No_cumple_requisito_de_tener_posgrado_en_derecho
        (no_cumple_requisito_de_tener_posgrado_en_derecho)
         =>
        (do-for-all-facts ((?f posderecho)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expdocenciaderecho
        (expdocenciaderecho)
         =>
        (printout t "¿Tiene más de 2 años de experiencia en docencia de derecho?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_en_docencia_de_derecho)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_en_docencia_de_derecho))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_en_docencia_de_derecho
        (cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_en_docencia_de_derecho)
         =>
        (do-for-all-facts ((?f expdocenciaderecho)) TRUE (retract ?f))
        (assert (expprofesionalderecho))
)

(defrule No_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_en_docencia_de_derecho
        (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_en_docencia_de_derecho)
         =>
        (do-for-all-facts ((?f expdocenciaderecho)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expprofesionalderecho
        (expprofesionalderecho)
         =>
        (printout t "¿Tiene más de 2 años de experiencia profesional?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_derecho)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_derecho))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_derecho
        (cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_derecho)
         =>
        (do-for-all-facts ((?f expprofesionalderecho)) TRUE (retract ?f))
        (assert (expcoordinacionderecho))
)

(defrule No_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_derecho
        (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_derecho)
         =>
        (do-for-all-facts ((?f expprofesionalderecho)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expcoordinacionderecho
        (expcoordinacionderecho)
         =>
        (printout t "¿Tiene experiencia en coordinación de programas académicos?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_experiencia_en_coordinacion_de_programas_academicos)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_experiencia_en_coordinacion_de_programas_academicos))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_experiencia_en_coordinacion_de_programas_academicos
        (cumple_requisito_de_tener_experiencia_en_coordinacion_de_programas_academicos)
         =>
        (do-for-all-facts ((?f expcoordinacionderecho)) TRUE (retract ?f))
        (assert (cargoderecho))
)

(defrule No_cumple_requisito_de_tener_experiencia_en_coordinacion_de_programas_academicos
        (no_cumple_requisito_de_tener_experiencia_en_coordinacion_de_programas_academicos)
         =>
        (do-for-all-facts ((?f expcoordinacionderecho)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Cargoderecho
        (cargoderecho)
         =>
        (printout t "Usted es apto para el cargo: Director de programa de derecho" crlf)
        (assert (es_apto_para_el_cargo_director_de_programa_de_derecho))
)

(defrule Es_apto_para_el_cargo_director_de_programa_de_derecho
        (es_apto_para_el_cargo_director_de_programa_de_derecho)
         =>
        (do-for-all-facts ((?f cargoderecho)) TRUE (retract ?f))
        (assert (finaliza_ejecucion_de_arbol))
)

(defrule Prediseno
        (prediseno)
         =>
        (printout t "¿Tiene pregrado en diseño gráfico o afines?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (tiene_pregrado_en_disenio_grafico_o_afines)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_tiene_pregrado_en_disenio_grafico_o_afines))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Tiene_pregrado_en_disenio_grafico_o_afines
        (tiene_pregrado_en_disenio_grafico_o_afines)
         =>
        (do-for-all-facts ((?f prediseno)) TRUE (retract ?f))
        (assert (posdiseno))
)

(defrule No_tiene_pregrado_en_disenio_grafico_o_afines
        (no_tiene_pregrado_en_disenio_grafico_o_afines)
         =>
        (do-for-all-facts ((?f prediseno)) TRUE (retract ?f))
        (assert (preingenieria))
)

(defrule Posdiseno
        (posdiseno)
         =>
        (printout t "¿Tiene posgrado en animación, diseño o afines?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (tiene_posgrado_en_animacion_disenio_o_afines)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_tiene_posgrado_en_animacion_disenio_o_afines))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Tiene_posgrado_en_animacion_disenio_o_afines
        (tiene_posgrado_en_animacion_disenio_o_afines)
         =>
        (do-for-all-facts ((?f posdiseno)) TRUE (retract ?f))
        (assert (expdocenciadiseno))
)

(defrule No_tiene_posgrado_en_animacion_disenio_o_afines
        (no_tiene_posgrado_en_animacion_disenio_o_afines)
         =>
        (do-for-all-facts ((?f posdiseno)) TRUE (retract ?f))
        (assert (docml))
)

(defrule Expdocenciadiseno
        (expdocenciadiseno)
         =>
        (printout t "¿Tiene más de 1 año de experiencia como docente de animación o plataformas 3D?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_de_docencia_en_animacion_o_plataformas_3d)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_de_docencia_en_animacion_o_plataformas_3d))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_de_docencia_en_animacion_o_plataformas_3d
        (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_de_docencia_en_animacion_o_plataformas_3d)
         =>
        (do-for-all-facts ((?f expdocenciadiseno)) TRUE (retract ?f))
        (assert (expproyectosdiseno))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_de_docencia_en_animacion_o_plataformas_3d
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_de_docencia_en_animacion_o_plataformas_3d)
         =>
        (do-for-all-facts ((?f expdocenciadiseno)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expproyectosdiseno
        (expproyectosdiseno)
         =>
        (printout t "¿Tiene más de 2 años de experiencia trabajando con proyectos 3D con difusión comercial?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_trabajando_con_proyectos_3d_de_difusion_comercial)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_trabajando_con_proyectos_3d_de_difusion_comercial))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_trabajando_con_proyectos_3d_de_difusion_comercial
        (cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_trabajando_con_proyectos_3d_de_difusion_comercial)
         =>
        (do-for-all-facts ((?f expproyectosdiseno)) TRUE (retract ?f))
        (assert (reelproductos))
)

(defrule No_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_trabajando_con_proyectos_3d_de_difusion_comercial
        (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_trabajando_con_proyectos_3d_de_difusion_comercial)
         =>
        (do-for-all-facts ((?f expproyectosdiseno)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Reelproductos
        (reelproductos)
         =>
        (printout t "¿Dispone de un Reel de productos de animación 3D en donde especifique su participación en cada proyecto?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (tiene_reel_de_productos_de_animacion_3d)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_tiene_reel_de_productos_de_animacion_3d))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Tiene_reel_de_productos_de_animacion_3d
        (tiene_reel_de_productos_de_animacion_3d)
         =>
        (do-for-all-facts ((?f reelproductos)) TRUE (retract ?f))
        (assert (softwareblender))
)

(defrule No_tiene_reel_de_productos_de_animacion_3d
        (no_tiene_reel_de_productos_de_animacion_3d)
         =>
        (do-for-all-facts ((?f reelproductos)) TRUE (retract ?f))
        (assert (modeladoyanimacion))
)

(defrule Softwareblender
        (softwareblender)
         =>
        (printout t "¿Tiene un nivel alto de manejo del software Blender?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cargofundamentosdigitales)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_es_apto_para_ningun_cargo))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_nivel_de_manejo_alto_en_software_blender
        (cumple_requisito_de_tener_nivel_de_manejo_alto_en_software_blender)
         =>
        (do-for-all-facts ((?f softwareblender)) TRUE (retract ?f))
        (assert (cargofundamentosdigitales))
)

(defrule No_cumple_requisito_de_tener_nivel_de_manejo_alto_en_software_blender
        (no_cumple_requisito_de_tener_nivel_de_manejo_alto_en_software_blender)
         =>
        (do-for-all-facts ((?f softwareblender)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Cargofundamentosdigitales
        (cargofundamentosdigitales)
         =>
        (printout t "Usted es apto para el cargo: Docente hora cátedra, fundamentos digitales 3D módulo 2" crlf) 
        (assert (es_apto_para_el_cargo_docente_hora_catedra_fundamentos_digitales_3D_modulo_2))
)

(defrule Es_apto_para_el_cargo_docente_hora_catedra_fundamentos_digitales_3D_modulo_2
        (es_apto_para_el_cargo_docente_hora_catedra_fundamentos_digitales_3D_modulo_2)
         =>
        (do-for-all-facts ((?f cargofundamentosdigitales)) TRUE (retract ?f))
        (assert (finaliza_ejecucion_de_arbol))
)

(defrule Modeladoyanimacion
        (modeladoyanimacion)
         =>
        (printout t "¿Tiene conocimientos de computación gráfica en modelado y animación en 2D y 3D?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_conocimientos_de_computacion_grafica_en_modelado_y_animacion_en_2d_y_3d)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_conocimientos_de_computacion_grafica_en_modelado_y_animacion_en_2d_y_3d))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_conocimientos_de_computacion_grafica_en_modelado_y_animacion_en_2d_y_3d
        (cumple_requisito_de_tener_conocimientos_de_computacion_grafica_en_modelado_y_animacion_en_2d_y_3d)
         =>
        (do-for-all-facts ((?f modeladoyanimacion)) TRUE (retract ?f))
        (assert (expedicion))
)

(defrule No_cumple_requisito_de_tener_conocimientos_de_computacion_grafica_en_modelado_y_animacion_en_2d_y_3d
        (no_cumple_requisito_de_tener_conocimientos_de_computacion_grafica_en_modelado_y_animacion_en_2d_y_3d)
         =>
        (do-for-all-facts ((?f modeladoyanimacion)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expedicion
        (expedicion)
         =>
        (printout t "¿Tiene experiencia en edición de video y audio digital?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_experiencia_en_edicion_de_video_y_audio_digital)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_experiencia_en_edicion_de_video_y_audio_digital))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_experiencia_en_edicion_de_video_y_audio_digital
        (cumple_requisito_de_tener_experiencia_en_edicion_de_video_y_audio_digital)
         =>
        (do-for-all-facts ((?f expedicion)) TRUE (retract ?f))
        (assert (fundamentosprogramacion))
)

(defrule No_cumple_requisito_de_tener_experiencia_en_edicion_de_video_y_audio_digital
        (no_cumple_requisito_de_tener_experiencia_en_edicion_de_video_y_audio_digital)
         =>
        (do-for-all-facts ((?f expedicion)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Fundamentosprogramacion
        (fundamentosprogramacion)
         =>
        (printout t "¿Tiene conocimientos de fundamentos de programación?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_conocimientos_de_fundamentos_de_programacion)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_tener_conocimientos_de_fundamentos_de_programacion))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_conocimientos_de_fundamentos_de_programacion
        (cumple_requisito_de_tener_conocimientos_de_fundamentos_de_programacion)
         =>
        (do-for-all-facts ((?f fundamentosprogramacion)) TRUE (retract ?f))
        (assert (cargodisenador))
)

(defrule No_cumple_requisito_de_tener_tener_conocimientos_de_fundamentos_de_programacion
        (no_cumple_requisito_de_tener_tener_conocimientos_de_fundamentos_de_programacion)
         =>
        (do-for-all-facts ((?f fundamentosprogramacion)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Cargodisenador
        (cargodisenador)
         =>
        (printout t "Usted es apto para el cargo: Docente de cátedra, diseñador gráfico." crlf) 
        (assert (es_apto_para_el_cargo_docente_de_catedra_diseniador_grafico))
)

(defrule Es_apto_para_el_cargo_docente_de_catedra_diseniador_grafico
        (es_apto_para_el_cargo_docente_de_catedra_diseniador_grafico)
         =>
        (do-for-all-facts ((?f cargodisenador)) TRUE (retract ?f))
        (assert (finaliza_ejecucion_de_arbol))
)

(defrule Docml
        (docml)
         =>
        (printout t "¿Tiene doctorado o maestría en data science o machine learning?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_doctorado_o_maestria_en_data_science_o_machine_learning)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_doctorado_o_maestria_en_data_science_o_machine_learning))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_doctorado_o_maestria_en_data_science_o_machine_learning
        (cumple_requisito_de_tener_doctorado_o_maestria_en_data_science_o_machine_learning)
         =>
        (do-for-all-facts ((?f docml)) TRUE (retract ?f))
        (assert (expdocenciaml))
)

(defrule No_cumple_requisito_de_tener_doctorado_o_maestria_en_data_science_o_machine_learning
        (no_cumple_requisito_de_tener_doctorado_o_maestria_en_data_science_o_machine_learning)
         =>
        (do-for-all-facts ((?f docml)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expdocenciaml
        (expdocenciaml)
         =>
        (printout t "¿Tiene más de 1 año de experiencia como docente de data science o machine learning?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_de_data_science_o_machine_learning)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_de_data_science_o_machine_learning))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_de_data_science_o_machine_learning
        (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_de_data_science_o_machine_learning)
         =>
        (do-for-all-facts ((?f expdocenciaml)) TRUE (retract ?f))
        (assert (expinvestigacionml))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_de_data_science_o_machine_learning
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_de_data_science_o_machine_learning)
         =>
        (do-for-all-facts ((?f expdocenciaml)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expinvestigacionml
        (expinvestigacionml)
         =>
        (printout t "¿Tiene más de 1 año de experiencia como investigador en data science o machine learning?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_investigador_en_data_science_o_machine_learning)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_investigador_en_data_science_o_machine_learning))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_investigador_en_data_science_o_machine_learning
        (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_investigador_en_data_science_o_machine_learning)
         =>
        (do-for-all-facts ((?f expinvestigacionml)) TRUE (retract ?f))
        (assert (cargoml))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_investigador_en_data_science_o_machine_learning
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_investigador_en_data_science_o_machine_learning)
         =>
        (do-for-all-facts ((?f expinvestigacionml)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Cargoml
        (cargoml)
         =>
        (printout t "Usted es apto para el cargo: Docente de cátedra, data science y/o machine learning." crlf) 
        (assert (es_apto_para_el_cargo_docente_de_catedra_data_science_y_o_machine_learning))
)

(defrule Es_apto_para_el_cargo_docente_de_catedra_data_science_y_o_machine_learning
        (es_apto_para_el_cargo_docente_de_catedra_data_science_y_o_machine_learning)
         =>
        (do-for-all-facts ((?f cargoml)) TRUE (retract ?f))
        (assert (finaliza_ejecucion_de_arbol))
)

(defrule Preingenieria
        (preingenieria)
         =>
        (printout t "¿Tiene pregrado en ingeniería?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (tiene_pregrado_en_ingenieria)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_tiene_pregrado_en_ingenieria))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Tiene_pregrado_en_ingenieria
        (tiene_pregrado_en_ingenieria)
         =>
        (do-for-all-facts ((?f preingenieria)) TRUE (retract ?f))
        (assert (posdiseno))
)

(defrule No_tiene_pregrado_en_ingenieria
        (no_tiene_pregrado_en_ingenieria)
         =>
        (do-for-all-facts ((?f preingenieria)) TRUE (retract ?f))
        (assert (prematematicas))
)

(defrule Prematematicas
        (prematematicas)
         =>
        (printout t "¿Tiene pregrado en matemáticas o estadística?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (tiene_pregrado_en_matematicas_o_estadistica)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_tiene_pregrado_en_matematicas_o_estadistica))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Tiene_pregrado_en_matematicas_o_estadistica
        (tiene_pregrado_en_matematicas_o_estadistica)
         =>
        (do-for-all-facts ((?f prematematicas)) TRUE (retract ?f))
        (assert (docml))
)

(defrule No_tiene_pregrado_en_matematicas_o_estadistica
        (no_tiene_pregrado_en_matematicas_o_estadistica)
         =>
        (do-for-all-facts ((?f prematematicas)) TRUE (retract ?f))
        (assert (prefisica))
)

(defrule Prefisica
        (prefisica)
         =>
        (printout t "¿Tiene pregrado en física o afines?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (tiene_pregrado_en_fisica_o_afines)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_tiene_pregrado_en_fisica_o_afines))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Tiene_pregrado_en_fisica_o_afines
        (tiene_pregrado_en_fisica_o_afines)
         =>
        (do-for-all-facts ((?f prefisica)) TRUE (retract ?f))
        (assert (docfisica))
)

(defrule No_tiene_pregrado_en_fisica_o_afines
        (no_tiene_pregrado_en_fisica_o_afines)
         =>
        (do-for-all-facts ((?f prefisica)) TRUE (retract ?f))
        (assert (preadministracion))
)

(defrule Docfisica
        (docfisica)
         =>
        (printout t "¿Tiene doctorado en física, física médica o física nuclear?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_doctorado_en_fisica_fisica_medica_o_fisica_nuclear)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_doctorado_en_fisica_fisica_medica_o_fisica_nuclear))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_doctorado_en_fisica_fisica_medica_o_fisica_nuclear
        (cumple_requisito_de_tener_doctorado_en_fisica_fisica_medica_o_fisica_nuclear)
         =>
        (do-for-all-facts ((?f docfisica)) TRUE (retract ?f))
        (assert (expdocenciafisica))
)

(defrule No_cumple_requisito_de_tener_doctorado_en_fisica_fisica_medica_o_fisica_nuclear
        (no_cumple_requisito_de_tener_doctorado_en_fisica_fisica_medica_o_fisica_nuclear)
         =>
        (do-for-all-facts ((?f docfisica)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expdocenciafisica
        (expdocenciafisica)
         =>
        (printout t "¿Tiene más de 1 año de experiencia como docente en el área de su doctorado?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_en_el_area_de_su_doctorado)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_en_el_area_de_su_doctorado))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_en_el_area_de_su_doctorado
        (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_en_el_area_de_su_doctorado)
         =>
        (do-for-all-facts ((?f expdocenciafisica)) TRUE (retract ?f))
        (assert (prodacademicafisica))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_en_el_area_de_su_doctorado
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_en_el_area_de_su_doctorado)
         =>
        (do-for-all-facts ((?f expdocenciafisica)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Prodacademicafisica
        (prodacademicafisica)
         =>
        (printout t "¿Tiene producción académica?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_produccion_academica_de_fisica)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_produccion_academica_de_fisica))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_produccion_academica_de_fisica
        (cumple_requisito_de_tener_produccion_academica_de_fisica)
         =>
        (do-for-all-facts ((?f prodacademicafisica)) TRUE (retract ?f))
        (assert (expestimaciondosis))
)

(defrule No_cumple_requisito_de_tener_produccion_academica_de_fisica
        (no_cumple_requisito_de_tener_produccion_academica_de_fisica)
         =>
        (do-for-all-facts ((?f prodacademicafisica)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expestimaciondosis
        (expestimaciondosis)
         =>
        (printout t "¿Tiene experiencia en la estimación de dosis de radiación?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_experiencia_en_la_estimacion_de_dosis_de_radiacion)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_experiencia_en_la_estimacion_de_dosis_de_radiacion))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_experiencia_en_la_estimacion_de_dosis_de_radiacion
        (cumple_requisito_de_tener_experiencia_en_la_estimacion_de_dosis_de_radiacion)
         =>
        (do-for-all-facts ((?f expestimaciondosis)) TRUE (retract ?f))
        (assert (expsimulacionesfisica))
)

(defrule No_cumple_requisito_de_tener_experiencia_en_la_estimacion_de_dosis_de_radiacion
        (no_cumple_requisito_de_tener_experiencia_en_la_estimacion_de_dosis_de_radiacion)
         =>
        (do-for-all-facts ((?f expestimaciondosis)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expsimulacionesfisica
        (expsimulacionesfisica)
         =>
        (printout t "¿Tiene experiencia en simulaciones físicas y teóricas para la estimación de dosis?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_experiencia_en_simulaciones_fisicas_y_teoricas_para_la_estimacion_de_dosis)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_experiencia_en_simulaciones_fisicas_y_teoricas_para_la_estimacion_de_dosis))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_experiencia_en_simulaciones_fisicas_y_teoricas_para_la_estimacion_de_dosis
        (cumple_requisito_de_tener_experiencia_en_simulaciones_fisicas_y_teoricas_para_la_estimacion_de_dosis)
         =>
        (do-for-all-facts ((?f expsimulacionesfisica)) TRUE (retract ?f))
        (assert (cargofisica))
)

(defrule No_cumple_requisito_de_tener_experiencia_en_simulaciones_fisicas_y_teoricas_para_la_estimacion_de_dosis
        (no_cumple_requisito_de_tener_experiencia_en_simulaciones_fisicas_y_teoricas_para_la_estimacion_de_dosis)
         =>
        (do-for-all-facts ((?f expsimulacionesfisica)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Cargofisica
        (cargofisica)
         =>
        (printout t "Usted es apto para el cargo: Docente de carrera o exclusivo, física radiológica." crlf) 
        (assert (es_apto_para_el_cargo_docente_de_carrera_o_exclusivo_de_fisica_radiologica))
)

(defrule Es_apto_para_el_cargo_docente_de_carrera_o_exclusivo_de_fisica_radiologica
        (es_apto_para_el_cargo_docente_de_carrera_o_exclusivo_de_fisica_radiologica)
         =>
        (do-for-all-facts ((?f cargofisica)) TRUE (retract ?f))
        (assert (finaliza_ejecucion_de_arbol))
)

(defrule Preadministracion
        (preadministracion)
         =>
        (printout t "¿Tiene pregrado en administración o afines?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_pregrado_en_administracion_o_afines)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_pregrado_en_administracion_o_afines))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_pregrado_en_administracion_o_afines
        (cumple_requisito_de_tener_pregrado_en_administracion_o_afines)
         =>
        (do-for-all-facts ((?f preadministracion)) TRUE (retract ?f))
        (assert (posadministracion))
)

(defrule No_cumple_requisito_de_tener_pregrado_en_administracion_o_afines
        (no_cumple_requisito_de_tener_pregrado_en_administracion_o_afines)
         =>
        (do-for-all-facts ((?f preadministracion)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Posadministracion
        (posadministracion)
         =>
        (printout t "¿Tiene posgrado en administración, gestión humana o SST?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_posgrado_en_administracion_gestion_humana_o_sst)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_posgrado_en_administracion_gestion_humana_o_sst))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_posgrado_en_administracion_gestion_humana_o_sst
        (cumple_requisito_de_tener_posgrado_en_administracion_gestion_humana_o_sst)
         =>
        (do-for-all-facts ((?f posadministracion)) TRUE (retract ?f))
        (assert (expprofesionaladministracion))
)

(defrule No_cumple_requisito_de_tener_posgrado_en_administracion_gestion_humana_o_sst
        (no_cumple_requisito_de_tener_posgrado_en_administracion_gestion_humana_o_sst)
         =>
        (do-for-all-facts ((?f posadministracion)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expprofesionaladministracion
        (expprofesionaladministracion)
         =>
        (printout t "¿Tiene más de 2 años de experiencia profesional?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_administracion)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_administracion))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_administracion
        (cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_administracion)
         =>
        (do-for-all-facts ((?f expprofesionaladministracion)) TRUE (retract ?f))
        (assert (expdocenteadministracion))
)

(defrule No_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_administracion
        (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_administracion)
         =>
        (do-for-all-facts ((?f expprofesionaladministracion)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Expdocenteadministracion
        (expdocenteadministracion)
         =>
        (printout t "¿Tiene más de 1 año de experiencia como docente con comunidades?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_con_comunidades)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_con_comunidades))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_con_comunidades
        (cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_con_comunidades)
         =>
        (do-for-all-facts ((?f expdocenteadministracion)) TRUE (retract ?f))
        (assert (prodacademicaadministracion))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_con_comunidades
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_con_comunidades)
         =>
        (do-for-all-facts ((?f expdocenteadministracion)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Prodacademicaadministracion
        (prodacademicaadministracion)
         =>
        (printout t "¿Tiene producción académica?" crlf)
        (bind ?opcion (read))
        (if (eq ?opcion SI) then 
            (assert (cumple_requisito_de_tener_produccion_academica_de_administracion)) 
        else 
            (if (eq ?opcion NO) then 
                (assert (no_cumple_requisito_de_tener_produccion_academica_de_administracion))
            )
        )
        (if (and (neq ?opcion NO) (neq ?opcion SI)) then
            (printout t "No ingresó una opción válida. Vuelva a ejecutar el sistema." crlf)
        )
)

(defrule Cumple_requisito_de_tener_produccion_academica_de_administracion
        (cumple_requisito_de_tener_produccion_academica_de_administracion)
         =>
        (do-for-all-facts ((?f prodacademicaadministracion)) TRUE (retract ?f))
        (assert (cargoadministracion))
)

(defrule No_cumple_requisito_de_tener_produccion_academica_de_administracion
        (no_cumple_requisito_de_tener_produccion_academica_de_administracion)
         =>
        (do-for-all-facts ((?f prodacademicaadministracion)) TRUE (retract ?f))
        (assert (no_es_apto_para_ningun_cargo))
)

(defrule Cargoadministracion
        (cargoadministracion)
         =>
        (printout t "Usted es apto para el cargo: Docente ocasional, CED (Centro de Educación para el Desarrollo)" crlf) 
        (assert (es_apto_para_el_cargo_docente_ocasional_centro_de_educacion_para_el_desarrollo))
)

(defrule Es_apto_para_el_cargo_docente_ocasional_centro_de_educacion_para_el_desarrollo
        (es_apto_para_el_cargo_docente_ocasional_centro_de_educacion_para_el_desarrollo)
         =>
        (do-for-all-facts ((?f cargoadministracion)) TRUE (retract ?f))
        (assert (finaliza_ejecucion_de_arbol))
)