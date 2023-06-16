//
//  ViewController.swift
//  Taxi Clone
//
//  Created by Mohanraj on 27/10/22.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class ViewController: UIViewController {
    let states = [
        state(name: "driverA",lat: 13.068500,long: 80.234938),
        state(name: "driverB",lat: 13.062306,long: 80.231172),
        state(name: "driverC",lat: 13.071086,long: 80.230709),
    ]
    var Drivername:String = ""
    var phoneNum = ""
    
    //For Locatoin update
    var mapView = GMSMapView()
    var locationManager:CLLocationManager! = CLLocationManager.init()
    var marker:GMSMarker = GMSMarker()
    
    @IBOutlet weak var maps: UIView!
    @IBOutlet weak var bookNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookNow.isHidden = true
        DispatchQueue.main.async {
            self.setupMap()
        }
    }
    
    func setupMap() {
        mapView.frame = self.maps.bounds
        self.maps.addSubview(mapView)
        mapView.isMyLocationEnabled = true
        
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){  // location services are enabled on the device
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 10
            locationManager.requestWhenInUseAuthorization() //  permission to use location services while the app is in the foreground
            locationManager.requestAlwaysAuthorization()    // permission to use location services regardless of whether the app is in use
            locationManager.startUpdatingLocation()         // Starts the generation of updates that report the user’s current location
        }
        mapView.settings.zoomGestures = false
        mapView.animate(toViewingAngle: 45)
        mapView.delegate = self
    }
    
    @IBAction func didClickBookNow(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingPage") as! BookingPageViewController
        vc.diverName = Drivername
        vc.mobNum = phoneNum
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController : CLLocationManagerDelegate, GMSMapViewDelegate {
    func setupDrivers() {
        DispatchQueue.main.async {
            for state in self.states {
                let state_marker = GMSMarker()
                self.marker.position = CLLocationCoordinate2D(latitude: state.long, longitude: state.lat)
                self.marker.title = state.name
                self.marker.snippet = "Hey, this is \(state.name)"
                state_marker.map = self.mapView
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last // find your device location
        mapView.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0) // show your device location on map
        mapView.settings.myLocationButton = true // show current location button
        let lat = (newLocation?.coordinate.latitude)! // get current location latitude
        let long = (newLocation?.coordinate.longitude)! //get current location longitude
        
        marker.position = CLLocationCoordinate2DMake(lat,long)
        marker.map = mapView
        print("Current Lat Long - " ,lat, long )
        setupDrivers()
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {  //GMSMapViewDelegate
        DispatchQueue.main.async {
            let position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let current = CLLocation(latitude: position.latitude, longitude: position.longitude)
            self.marker.position = position
            self.marker.map = mapView
            self.marker.icon = UIImage(named: "default_marker")
            print("New Marker Lat Long - ",coordinate.latitude, coordinate.longitude)
            
            let driveLocationA = CLLocation(latitude: 13.068500, longitude: 80.234938)
            let driveLocationB = CLLocation(latitude: 13.062306, longitude: 80.231172)
            let driveLocationC = CLLocation(latitude: 13.071086, longitude: 80.230709)
            
            //Measuring my distance to my driver's (in km)
            let distanceA = current.distance(from: driveLocationA) / 1000
            let distanceB = current.distance(from: driveLocationB) / 1000
            let distanceC = current.distance(from: driveLocationC) / 1000
            
            //Display the distance in km
            print(String(format: "The distance to driverA is %.01fkm", distanceA))
            print(String(format: "The distance to driverB is %.01fkm", distanceB))
            print(String(format: "The distance to driverC is %.01fkm", distanceC))
            
            if(distanceA < 1) || (distanceB < 1) || (distanceC < 1){
                self.bookNow.isHidden = false
            }else{
                self.bookNow.isHidden = true
            }
            
            if(distanceA < distanceB),(distanceA < distanceC){
                self.Drivername = "Driver A"
                self.phoneNum = "9876543212"
            }
            else if (distanceB < distanceC),(distanceB < distanceA){
                self.Drivername = "Driver B"
                self.phoneNum = "9876543212"
            }
            else if (distanceC < distanceA),(distanceC < distanceB){
                self.Drivername = "Driver C"
                self.phoneNum = "9876543212"
            }
            else if (distanceA == distanceB),(distanceB < distanceC){
                self.Drivername = "Driver A"
                self.phoneNum = "9876543212"
            }
            else if (distanceB == distanceC),(distanceC < distanceA){
                self.Drivername = "Driver B"
                self.phoneNum = "9876543212"
            }
            else{
                self.Drivername = "Driver A"
                self.phoneNum = "9876543212"
            }
        }
    }
}
