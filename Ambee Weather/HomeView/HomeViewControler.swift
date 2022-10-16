//
//  HomeViewControler.swift
//  Ambee Weather
//
//  Created by suryansh Bisen on 15/10/22.
//

import Foundation
import MapKit

class HomeViewControler: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var weatherData = WeatherModel()
    @Published var isNoLocation = false
    @Published var status: Status = .isLoading
    var locationManager: CLLocationManager
    
    
    override init() {
         locationManager = CLLocationManager()
         super.init()
         locationManager.delegate = self
      }
    
    func getData() {
        
        locationManager.requestWhenInUseAuthorization()
        
        guard (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) else {
            return
        }
        
        let url = URL(string: "\(Constents.weatherURL)?lat=\( locationManager.location?.coordinate.latitude ?? 0.0)&lon=\(locationManager.location?.coordinate.longitude ?? 0.0)&appid=\(Constents.apiKey)&units=metric")
        
        
        ApiNetworking.apiCall(WeatherModel.self, url: URLRequest(url: url!)) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.weatherData = data
                }
                print(data)
            case .failure(let failure):
                print(failure)
            }
            DispatchQueue.main.async {
                self.status = .isActive
            }
            
        }

        
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        print("Status: \(status)")
        if status.rawValue == 4 {
            getData()
        }else if status.rawValue == 2 {
            self.status = .noPermition
        }
    }

    
}

enum Status {
    case isLoading, ApiError, noPermition, isActive
}
