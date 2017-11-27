//
//  Transporte_ViewController.swift
//  MueveSF
//
//  Created by Marvi on 21/11/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit

class Transporte_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        switch segue.identifier{
            case "metro"?:
                let siguienteV = segue.destination as! Lugares_TableViewController
                siguienteV.trans = "metro"
            break
            
            case "bici"?:
                let siguienteV = segue.destination as! Lugares_TableViewController
                siguienteV.trans = "bici"
            break
            
            case "carro"?:
                let siguienteV = segue.destination as! Lugares_TableViewController
                siguienteV.trans = "carro"
            break
            
            case "metroBus"?:
                let siguienteV = segue.destination as! Lugares_TableViewController
                siguienteV.trans = "metroBus"
            break
            
            case "rtp"?:
                let siguienteV = segue.destination as! Lugares_TableViewController
                siguienteV.trans = "rtp"
            break
            
            default:
            break
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
