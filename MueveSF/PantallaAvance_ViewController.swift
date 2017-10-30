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

class PantallaAvance_ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var Map: MKMapView!
    @IBOutlet weak var mapa: UIImageView!
    @IBOutlet weak var timer: UILabel!
    
    var t = Timer()
    var counter = 0
    var x = Timer()
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

    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
     }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius,regionRadius)
        Map.setRegion(coordinateRegion, animated: true)
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
}
