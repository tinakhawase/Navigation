//
//  AllaboutCLLocationViewController.swift
//  LocationTracker
//
//  Created by Deepashri Khawase on 01.05.19.
//  Copyright © 2019 Deep Yoga. All rights reserved.
//

import UIKit
//import CoreLocation

class AllaboutCLLocationViewController: UIViewController {
    
    //LocationManagerConfigurable,LocationProvidable,LocationObservable
    
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last,
            let listener = self.listener else {
                return
        }
        
        if currentLocation != nil && Double((currentLocation?.distance(from: lastLocation))!) < 100.0 {
            //print("current Location \(String(describing: currentLocation?.coordinate)) is same as last Location: \(String(describing: lastLocation.coordinate))")
            return
        }
        
        currentLocation = lastLocation
        listener.setCurrentLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
    }
    
    
    
    
    
    
    
    
    
    
    
    func setDelegate(to instance: AnyObject) {
        <#code#>
    }
    
    func setDesiredAccuracy(to accuracy: Double) {
        <#code#>
    }
    
    func requestAlwaysAuthorization() {
        <#code#>
    }
    
    func startUpdatingLocation() {
        <#code#>
    }
    
    var listener: LocationObservable?
    
    func setListener(listener: LocationObservable) {
        <#code#>
    }
    
    func startLocationUpdates() {
        <#code#>
    }
    
    func getCurrentLocation() -> (Double, Double) {
        <#code#>
    }
    
    func setCurrentLocation(latitude: Double, longitude: Double) {
        <#code#>
    }
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
     init(locationManager:LocationManagerConfigurable){
     self.locationManager = locationManager
     }
     
     required init?(coder aDecoder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
     }
     
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     guard let lastLocation = locations.last,
     let listener = self.listener else {
     return
     }
     
     if currentLocation != nil && Double((currentLocation?.distance(from: lastLocation))!) < 100.0 {
     //print("current Location \(String(describing: currentLocation?.coordinate)) is same as last Location: \(String(describing: lastLocation.coordinate))")
     return
     }
     
     currentLocation = lastLocation
     listener.setCurrentLocation(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
     }
     
    */

}

protocol LocationProvidable {
    var listener: LocationObservable? { get set }
    func setListener(listener: LocationObservable)
    func startLocationUpdates()
    func getCurrentLocation() -> (Double, Double)
}
protocol LocationObservable {
    func setCurrentLocation(latitude: Double, longitude: Double)
}
protocol LocationManagerConfigurable {
    // wrap `delegate` and `desiredAccuracy` to make it decoupled
    func setDelegate(to instance: AnyObject)
    func setDesiredAccuracy(to accuracy: Double)
    func requestAlwaysAuthorization()
    func startUpdatingLocation()
}

// CoreLocation extenstion for protocol conformance
extension CLLocationManager: LocationManagerConfigurable {
    func setDelegate(to instance: AnyObject) {
        guard let delegate = instance as? CLLocationManagerDelegate else {
            return
        }
        self.delegate = delegate
    }
    func setDesiredAccuracy(to accuracy: Double) {
        let accuracy = accuracy as CLLocationAccuracy
        self.desiredAccuracy = accuracy
    }
    
    
    init(locationManager:LocationManagerConfigurable){
        self.locationManager = locationManager
    }
    
    
    
    
    
    
    
    
    
    
}
*/
}
