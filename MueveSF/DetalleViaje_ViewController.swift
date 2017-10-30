//
//  DetalleViaje_ViewController.swift
//  MueveSF
//
//  Created by Marvi on 29/10/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit

class DetalleViaje_ViewController: UIViewController {
    @IBOutlet weak var trans: UILabel!
    @IBOutlet weak var inicio: UILabel!
    @IBOutlet weak var vel: UILabel!
    @IBOutlet weak var fin: UILabel!
    @IBOutlet weak var nom: UILabel!
    
    var nombre:String = ""
    var typ:String = ""
    var dateI:String = ""
    var dateF:String = ""
    var spd:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nom.text = nombre
        trans.text = typ
        inicio.text = dateI
        fin.text = dateF
        vel.text = spd+" km"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
