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
        (remove  initial-fact)
        (remove malarespuesta)
        (printout t "A continuación se le mostrarán varias preguntas." crlf)
        (printout t "Responda SI (en mayúscula) para responder afirmativamente y NO (en mayúscula) para responder negativamente." crlf)
        (printout t "Si tiene alguna duda en cualquier punto de la ejecución respecto a una pregunta o algo que se le muestre, puede escribir AYUDA (en mayúscula) y se le brindará orientación." crlf)
        (printout t crlf "¿Desea empezar con las preguntas?" crlf)
        (bind ?opcion (read))
        (assert (opcion_menu ?opcion))
        (if (eq ?opcion SI) then 
            (assert (lengua))
        else (assert (malarespuesta))
        )
)

(defrule Malarespuesta
        (malarespuesta)
         =>
        (printout t "Su respuesta indica que no desea empezar con las preguntas, por favor lea y responda de nuevo." crlf)
        (remove inicia_ejecucion_de_arbol)
        (assert (inicia_ejecucion_de_arbol))
)

(defrule Recorrido
        (recorrido)
         =>
        (remove  opcion_menu)
        (remove  recorrido)
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
        (remove  lengua)
        (assert (pregrado))
)

(defrule No_cumple_requisito_de_hablar_segunda_lengua
        (no_cumple_requisito_de_hablar_segunda_lengua)
         =>
        (remove  lengua)
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
        (remove  pregrado)
        (assert (posgrado))
)

(defrule No_cumple_requisito_de_tener_pregrado
        (no_cumple_requisito_de_tener_pregrado)
         =>
        (remove  pregrado)
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
        (remove  posgrado)
        (assert (prederecho))
)

(defrule No_cumple_requisito_de_tener_posgrado
        (no_cumple_requisito_de_tener_posgrado)
         =>
        (remove  posgrado)
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
        (remove  prederecho)
        (assert (posderecho))
)

(defrule No_tiene_pregrado_en_derecho
        (no_tiene_pregrado_en_derecho)
         =>
        (remove  prederecho)
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
        (remove  posderecho)
        (assert (expdocenciaderecho))
)

(defrule No_cumple_requisito_de_tener_posgrado_en_derecho
        (no_cumple_requisito_de_tener_posgrado_en_derecho)
         =>
        (remove  posderecho)
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
        (remove  expdocenciaderecho)
        (assert (expprofesionalderecho))
)

(defrule No_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_en_docencia_de_derecho
        (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_en_docencia_de_derecho)
         =>
        (remove  expdocenciaderecho)
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
        (remove  expprofesionalderecho)
        (assert (expcoordinacionderecho))
)

(defrule No_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_derecho
        (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_derecho)
         =>
        (remove  expprofesionalderecho)
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
        (remove  expcoordinacionderecho)
        (assert (cargoderecho))
)

(defrule No_cumple_requisito_de_tener_experiencia_en_coordinacion_de_programas_academicos
        (no_cumple_requisito_de_tener_experiencia_en_coordinacion_de_programas_academicos)
         =>
        (remove  expcoordinacionderecho)
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
        (remove  cargoderecho)
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
        (remove  prediseno)
        (assert (posdiseno))
)

(defrule No_tiene_pregrado_en_disenio_grafico_o_afines
        (no_tiene_pregrado_en_disenio_grafico_o_afines)
         =>
        (remove  prediseno)
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
        (remove  posdiseno)
        (assert (expdocenciadiseno))
)

(defrule No_tiene_posgrado_en_animacion_disenio_o_afines
        (no_tiene_posgrado_en_animacion_disenio_o_afines)
         =>
        (remove  posdiseno)
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
        (remove  expdocenciadiseno)
        (assert (expproyectosdiseno))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_de_docencia_en_animacion_o_plataformas_3d
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_de_docencia_en_animacion_o_plataformas_3d)
         =>
        (remove  expdocenciadiseno)
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
        (remove  expproyectosdiseno)
        (assert (reelproductos))
)

(defrule No_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_trabajando_con_proyectos_3d_de_difusion_comercial
        (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_trabajando_con_proyectos_3d_de_difusion_comercial)
         =>
        (remove  expproyectosdiseno)
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
        (remove  reelproductos)
        (assert (softwareblender))
)

(defrule No_tiene_reel_de_productos_de_animacion_3d
        (no_tiene_reel_de_productos_de_animacion_3d)
         =>
        (remove  reelproductos)
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
        (remove  softwareblender)
        (assert (cargofundamentosdigitales))
)

(defrule No_cumple_requisito_de_tener_nivel_de_manejo_alto_en_software_blender
        (no_cumple_requisito_de_tener_nivel_de_manejo_alto_en_software_blender)
         =>
        (remove  softwareblender)
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
        (remove  cargofundamentosdigitales)
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
        (remove  modeladoyanimacion)
        (assert (expedicion))
)

(defrule No_cumple_requisito_de_tener_conocimientos_de_computacion_grafica_en_modelado_y_animacion_en_2d_y_3d
        (no_cumple_requisito_de_tener_conocimientos_de_computacion_grafica_en_modelado_y_animacion_en_2d_y_3d)
         =>
        (remove  modeladoyanimacion)
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
        (remove  expedicion)
        (assert (fundamentosprogramacion))
)

(defrule No_cumple_requisito_de_tener_experiencia_en_edicion_de_video_y_audio_digital
        (no_cumple_requisito_de_tener_experiencia_en_edicion_de_video_y_audio_digital)
         =>
        (remove  expedicion)
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
        (remove  fundamentosprogramacion)
        (assert (cargodisenador))
)

(defrule No_cumple_requisito_de_tener_tener_conocimientos_de_fundamentos_de_programacion
        (no_cumple_requisito_de_tener_tener_conocimientos_de_fundamentos_de_programacion)
         =>
        (remove  fundamentosprogramacion)
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
        (remove  cargodisenador)
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
        (remove  docml)
        (assert (expdocenciaml))
)

(defrule No_cumple_requisito_de_tener_doctorado_o_maestria_en_data_science_o_machine_learning
        (no_cumple_requisito_de_tener_doctorado_o_maestria_en_data_science_o_machine_learning)
         =>
        (remove  docml)
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
        (remove  expdocenciaml)
        (assert (expinvestigacionml))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_de_data_science_o_machine_learning
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_de_data_science_o_machine_learning)
         =>
        (remove  expdocenciaml)
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
        (remove  expinvestigacionml)
        (assert (cargoml))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_investigador_en_data_science_o_machine_learning
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_investigador_en_data_science_o_machine_learning)
         =>
        (remove  expinvestigacionml)
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
        (remove  cargoml)
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
        (remove  preingenieria)
        (assert (posdiseno))
)

(defrule No_tiene_pregrado_en_ingenieria
        (no_tiene_pregrado_en_ingenieria)
         =>
        (remove  preingenieria)
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
        (remove  prematematicas)
        (assert (docml))
)

(defrule No_tiene_pregrado_en_matematicas_o_estadistica
        (no_tiene_pregrado_en_matematicas_o_estadistica)
         =>
        (remove  prematematicas)
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
        (remove  prefisica)
        (assert (docfisica))
)

(defrule No_tiene_pregrado_en_fisica_o_afines
        (no_tiene_pregrado_en_fisica_o_afines)
         =>
        (remove  prefisica)
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
        (remove  docfisica)
        (assert (expdocenciafisica))
)

(defrule No_cumple_requisito_de_tener_doctorado_en_fisica_fisica_medica_o_fisica_nuclear
        (no_cumple_requisito_de_tener_doctorado_en_fisica_fisica_medica_o_fisica_nuclear)
         =>
        (remove  docfisica)
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
        (remove  expdocenciafisica)
        (assert (prodacademicafisica))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_en_el_area_de_su_doctorado
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_en_el_area_de_su_doctorado)
         =>
        (remove  expdocenciafisica)
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
        (remove  prodacademicafisica)
        (assert (expestimaciondosis))
)

(defrule No_cumple_requisito_de_tener_produccion_academica_de_fisica
        (no_cumple_requisito_de_tener_produccion_academica_de_fisica)
         =>
        (remove  prodacademicafisica)
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
        (remove  expestimaciondosis)
        (assert (expsimulacionesfisica))
)

(defrule No_cumple_requisito_de_tener_experiencia_en_la_estimacion_de_dosis_de_radiacion
        (no_cumple_requisito_de_tener_experiencia_en_la_estimacion_de_dosis_de_radiacion)
         =>
        (remove  expestimaciondosis)
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
        (remove  expsimulacionesfisica)
        (assert (cargofisica))
)

(defrule No_cumple_requisito_de_tener_experiencia_en_simulaciones_fisicas_y_teoricas_para_la_estimacion_de_dosis
        (no_cumple_requisito_de_tener_experiencia_en_simulaciones_fisicas_y_teoricas_para_la_estimacion_de_dosis)
         =>
        (remove  expsimulacionesfisica)
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
        (remove  cargofisica)
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
        (remove  preadministracion)
        (assert (posadministracion))
)

(defrule No_cumple_requisito_de_tener_pregrado_en_administracion_o_afines
        (no_cumple_requisito_de_tener_pregrado_en_administracion_o_afines)
         =>
        (remove  preadministracion)
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
        (remove  posadministracion)
        (assert (expprofesionaladministracion))
)

(defrule No_cumple_requisito_de_tener_posgrado_en_administracion_gestion_humana_o_sst
        (no_cumple_requisito_de_tener_posgrado_en_administracion_gestion_humana_o_sst)
         =>
        (remove  posadministracion)
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
        (remove  expprofesionaladministracion)
        (assert (expdocenteadministracion))
)

(defrule No_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_administracion
        (no_cumple_requisito_de_tener_mas_de_2_anios_de_experiencia_profesional_en_administracion)
         =>
        (remove  expprofesionaladministracion)
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
        (remove  expdocenteadministracion)
        (assert (prodacademicaadministracion))
)

(defrule No_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_con_comunidades
        (no_cumple_requisito_de_tener_mas_de_1_anio_de_experiencia_como_docente_con_comunidades)
         =>
        (remove  expdocenteadministracion)
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
        (remove  prodacademicaadministracion)
        (assert (cargoadministracion))
)

(defrule No_cumple_requisito_de_tener_produccion_academica_de_administracion
        (no_cumple_requisito_de_tener_produccion_academica_de_administracion)
         =>
        (remove  prodacademicaadministracion)
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
        (remove  cargoadministracion)
        (assert (finaliza_ejecucion_de_arbol))
)