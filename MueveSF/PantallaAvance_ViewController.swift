//
//  PantallaAvance_ViewController.swift
//  MueveSF
//
//  Created by admin on 12/09/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData


class PantallaAvance_ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet var pan: UIPanGestureRecognizer!
    @IBOutlet weak var Map: MKMapView!
    @IBOutlet weak var mapa: UIImageView!
    @IBOutlet weak var timer: UILabel!
    
    var viajes: [NSManagedObject] = []
    var vAnn:[viaje] = []
    var trans:String = ""
    var lugar: String = ""
    var lat = 0.0
    var lon = 0.0
    var t = Timer()
    var counter = 0
    var x = Timer()
    var bandera = false
    

    //@IBAction func stop(_ sender: UIButton) {
        //t.invalidate()
        //counter = 0
      //  timer.text = String("00:00:00")
        
    //}
    
    @objc let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
    var location = CLLocation(latitude: 21.282778, longitude: -157.829444)
    @IBAction func showM(_ sender: UIButton) {
        if Map.isHidden {
            sender .setTitle("Ocultar Mapa", for: UIControlState .normal)
            Map.isHidden = false
        }
        else{
            sender .setTitle("Mostrar Mapa", for: UIControlState .normal)
            Map.isHidden = true
        }
    }

    @IBAction func rotate(_ sender: UIRotationGestureRecognizer) {
       bandera = false
    }
    
    @IBAction func pinch(_ sender: UIPinchGestureRecognizer) {
        bandera = false
    }
    
    @IBAction func mover(_ sender: UIPanGestureRecognizer) {
        bandera = false
    }
    
    @IBAction func doble(_ sender: UITapGestureRecognizer) {
        bandera = false
    }
    
    @IBAction func long(_ sender: UILongPressGestureRecognizer) {
        bandera = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bandera = true
        Annotation()
        Map.addAnnotations(vAnn)
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.Map.showsUserLocation = true;
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        timer.text = String("00:00:00")
        t = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(PantallaAvance_ViewController.updateCounter), userInfo: nil, repeats: true)
        
        Map.isHidden = false
        x = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(getter: PantallaAvance_ViewController.locationManager), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.º
     }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if bandera == true {
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius,regionRadius)
            lat = locValue.latitude
            lon = locValue.longitude
            Map.setRegion(coordinateRegion, animated: true)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateCounter() {
        counter += 1
        let hrs = counter/36000
        let min = (counter%3600)/60
        let seg = (counter%3600)%60
        var segtxt:String
        var txt = ""
        if seg < 10 {
            segtxt = "0\(seg)"
        } else {
            segtxt = "\(seg)"
        }
        if min<10 {
            txt = "0\(hrs):0\(min):\(segtxt)"
        }else{
        txt = "0\(hrs):\(min):\(segtxt)"
        }
        timer.text = String(txt)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
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
        
        if segue.identifier == "detenerSegue"{
            let v = viaje(
            title: lugar,
            duracion: timer.text!,
            transporte: trans,
            coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            Map.addAnnotation(v)
            vAnn.append(v)
            
            let entity = NSEntityDescription.entity(forEntityName: "Viaje", in: managedContext)!
            let via = NSManagedObject(entity: entity, insertInto: managedContext)
            
            via.setValue("1029382490", forKey: "user")
            via.setValue(trans, forKey: "transporte")
            let date = Date()
            let formatter = DateFormatter()
            let result = formatter.string(from: date)
            formatter.dateFormat = "yyyy-MM-dd"
            via.setValue(result, forKey: "date_inicio")
            via.setValue(result, forKey: "date_fin")
            via.setValue("50", forKey: "avg_speed")
            via.setValue("Nuevo", forKey: "nombre")
            via.setValue(String(lat), forKey: "latitud")
            via.setValue(String(lon), forKey: "longitud")
            via.setValue(timer.text, forKey: "duracion")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func Annotation(){
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Viaje")
        
        do {
            viajes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for item in viajes{
            for _ in item.entity.attributesByName.keys{
                let v = viaje(
                    title: item.value(forKey: "nombre") as! String,
                    duracion: item.value(forKey: "duracion") as! String,
                    transporte: item.value(forKey: "transporte") as! String,
                    coordinate: CLLocationCoordinate2D(latitude: Double(item.value(forKey: "latitud") as! String)!, longitude: Double(item.value(forKey: "longitud") as! String!)!)
                )
            vAnn.append(v)
            }
        }
    }
}
