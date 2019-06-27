/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.logging.Level;
import java.util.logging.Logger;
import jess.JessEvent;
import jess.JessException;
import jess.Rete;

/**
 *
 * @author Alex
 */
public class MotorController{
    Rete motor;

    public MotorController() {
        try {
            motor = new Rete();
            
            motor.reset();
            motor.batch("clips/arbol.clp");
        } catch (JessException ex) {
            Logger.getLogger(MotorController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void afirmar(String hecho) throws JessException{
        System.out.println(); //Solo para agregar una linea..
        motor.assertString(hecho);
        motor.run();
    }
    
    public void addEscuchador(EventHandler eventController){
        motor.addJessListener(eventController);
        motor.setEventMask(motor.getEventMask() | JessEvent.DEFRULE_FIRED);
    }
    
    public void ejecutar(){
        try {
            motor.run();
        } catch (JessException ex) {
            Logger.getLogger(MotorController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
