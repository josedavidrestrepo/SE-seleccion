/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import utils.Helper;
import views.ZooView;
import jess.*;

/**
 *
 * @author Alex
 */
public class EventHandler implements JessListener{

    ZooView vista;
    public EventHandler(ZooView vista) {
        this.vista = vista;
    }

    @Override
    public void eventHappened(JessEvent je){
        int defaultMask = JessEvent.DEFRULE_FIRED;
        int type = je.getType();
        Rete rete = (Rete)je.getSource();
        Context context = je.getContext();
        Helper helper = new Helper(rete);

        if(type == JessEvent.DEFRULE_FIRED){
           Fact nodoActual = helper.findFactByTempleteName("MAIN::nodo-actual");
            if (nodoActual != null){
                String slotV;
                Fact nodo = null;
                try {
                    slotV = nodoActual.get(0).toString();
                    nodo = helper.findFactByTemplateName("MAIN::Nodo", "nombre", slotV);
                    if (nodo != null){
                        String tipo = nodo.getSlotValue("tipo").stringValue(context);
                        if (tipo.equals("pregunta")){
                            String pregunta = nodo.getSlotValue("pregunta").stringValue(context);
                            vista.cambiarPregunta(pregunta);
                        }else if(tipo.equals("respuesta")){
                            String respuesta = nodo.getSlotValue("respuesta").stringValue(context);
                            vista.darRespuesta("El animal es: "+respuesta);
                        }
                    }
                } catch (JessException e) {
                    e.printStackTrace();
                }
            }
        }
        
    }
    
}
