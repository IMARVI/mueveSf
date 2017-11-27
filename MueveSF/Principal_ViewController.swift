//
//  Principal_ViewController.swift
//  MueveSF
//
//  Created by Marvi on 26/11/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit
import CoreData

class Principal_ViewController: UIViewController {

    let direccion = "http://199.233.252.86/201713/SwitchesDeMarfil/lugares_visitados.json"
    var nuevoArray : [Any]?
    var searchActive : Bool = false
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: direccion)
        let datos = try? Data(contentsOf: url!)
        nuevoArray = try! JSONSerialization.jsonObject(with: datos!) as? [Any]
        
        toCoreData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toCoreData(){
        var i = 0
        let persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "MueveSF")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error {
                    fatalError("Unresolved error \(error), \(error)")
                }
            })
            return container
        }()
        
        let managedContext = persistentContainer.viewContext
        
        for _ in nuevoArray!{
            let obj = nuevoArray?[i] as! [String: Any]
            let entity = NSEntityDescription.entity(forEntityName: "Viaje", in: managedContext)!
            let viaje = NSManagedObject(entity: entity, insertInto: managedContext)

            viaje.setValue(obj["usr"], forKey: "user")
            viaje.setValue(obj["type"], forKey: "transporte")
            viaje.setValue(obj["date_inicio"], forKey: "date_inicio")
            viaje.setValue(obj["date_fin"], forKey: "date_fin")
            viaje.setValue(obj["avg_speed"], forKey: "avg_speed")
            viaje.setValue(obj["nombre"], forKey: "nombre")
            viaje.setValue(obj["latitud"], forKey: "latitud")
            viaje.setValue(obj["longitud"], forKey: "longitud")
            viaje.setValue(obj["duracion"], forKey: "duracion")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            i = i+1
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
