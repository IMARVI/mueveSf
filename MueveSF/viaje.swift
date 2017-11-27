//
//  viaje.swift
//  MueveSF
//
//  Created by Marvi on 21/11/17.
//  Copyright © 2017 marvi. All rights reserved.
//

import MapKit


class viaje: NSObject, MKAnnotation {
    let transporte: String
    let duracion: String
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, duracion: String, transporte: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.duracion = duracion
        self.transporte = transporte
        self.coordinate = coordinate
        super.init()
    }
    
    var subtitle: String? {
        return transporte
    }
}

