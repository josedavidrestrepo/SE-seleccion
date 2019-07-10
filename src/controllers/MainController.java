/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import views.MainView;

public class MainController {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        MainView mainView = new MainView();
        MotorController motorController = new MotorController();        
        EventHandler eventController = new EventHandler(mainView);
        
        mainView.setMotorController(motorController);
        
        motorController.addEscuchador(eventController);
        
        motorController.ejecutar();
        
    }
    
}
