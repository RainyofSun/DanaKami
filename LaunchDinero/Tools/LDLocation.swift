//
//  LDLocation.swift
//  LaunchDinero
//
//  Created by wangxiang on 2025/2/24.
//

import Foundation
import CoreLocation

class LDLocation: NSObject, CLLocationManagerDelegate {
    static let shared = LDLocation()
    
    var LocationClourse: (() -> Void)?
    var AddressClourse: ((String, String, String, String, String, String) -> Void)?
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    var lm = CLLocationManager()
    
    let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        lm.delegate = self
    }
    
    func config() {
        lm.distanceFilter = 0.01
        lm.requestWhenInUseAuthorization()
    }
    
    func start() {
        lm.delegate = self
        lm.startUpdatingLocation()
    }
    
    func stop() {
        lm.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            self.longitude = floor(location.coordinate.longitude * 1_000_000) / 1_000_000
            
            self.latitude = floor(location.coordinate.latitude * 1_000_000) / 1_000_000
            
            self.LocationClourse?()
            
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let placemark = placemarks?.first {
                    self.AddressClourse?(
                        placemark.country ?? "",
                        placemark.isoCountryCode ?? "",
                        placemark.administrativeArea ?? "",
                        placemark.locality ?? "",
                        placemark.subLocality ?? "",
                        placemark.thoroughfare ?? ""
                    )
                }
            }
        }
    }
    
}
