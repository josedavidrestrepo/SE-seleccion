(deftemplate Nodo
	(slot nombre)
	(slot tipo )
	(slot pregunta)
	(slot respuesta)
	(slot nodo-si)
	(slot nodo-no)
	(slot ayuda)
)

(defrule inicio
	(not (Nodo (nombre nodo-lengua)))
	=>
	(load-facts "clips/nodos.dat")
	(assert (nodo-actual nodo-lengua))
)

; preguntamos y almacenamos la respuesta ..
(defrule preguntar-Nodo
	(nodo-actual ?nombre-actual)
	(Nodo (tipo pregunta) (nombre ?nombre-actual) (pregunta ?pregunta))
	(not (respuesta ?))
	=>
	(printout t ?pregunta " : ")
)

(defrule respuesta-incorrecta
	?respuesta <- (respuesta ?resp&~si&~no)
	=>
	(printout t "Responda (si o no) unicamente .. " crlf)
	(retract ?respuesta)
)

(defrule nodo-pregunta-si
	?respuesta <- (respuesta si)
	?nodo-actual <- (nodo-actual ?nombre-actual)
	(Nodo (tipo pregunta) (nombre ?nombre-actual) (nodo-si ?nodo-si))
	=>
	(retract ?respuesta ?nodo-actual)
	(assert (nodo-actual ?nodo-si))
)

(defrule nodo-pregunta-no
	?respuesta <- (respuesta no)
	?nodo-actual <- (nodo-actual ?nombre-actual)
	(Nodo (tipo pregunta) (nombre ?nombre-actual) (nodo-no ?nodo-no))
	=>
	(retract ?respuesta ?nodo-actual)
	(assert (nodo-actual ?nodo-no))
)


(defrule nodo-respuesta
	;?respuesta <- (respuesta si)
	?nodo-actual <- (nodo-actual ?nombre-actual)
	(Nodo (tipo respuesta) (nombre ?nombre-actual) (respuesta ?respuesta))
	=>
	(assert (respuesta-final ?respuesta))
	(printout t ?respuesta crlf )
	(retract  ?nodo-actual)
	(assert (ir-a-la-raiz-preguntar))
)


(defrule ir-a-la-raiz-preguntar
	(ir-a-la-raiz-preguntar)
	(not (respuesta))
	=>
	(printout t "Desea continuar la busqueda? (si/no): ")
)

(defrule una-vez-mas
	?ir <- (ir-a-la-raiz-preguntar)
	?resp <- (respuesta si)
	=>
	(retract ?ir ?resp)
	(assert (nodo-actual nodo-lengua))
)

(defrule no-mas
	?ir <- (ir-a-la-raiz-preguntar)
	?resp <- (respuesta no)
	=>
	(retract ?ir ?resp)
)
