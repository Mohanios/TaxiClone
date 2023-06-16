//
//  StateModel.swift
//  Taxi Clone
//
//  Created by Mohanraj on 27/10/22.
//

import Foundation
import CoreLocation

struct state {
    let name : String
    let lat : CLLocationDegrees
    let long : CLLocationDegrees
    
    init(name:String,lat:CLLocationDegrees,long:CLLocationDegrees){
        self.name = name
        self.lat = lat
        self.long = long
    }
}
