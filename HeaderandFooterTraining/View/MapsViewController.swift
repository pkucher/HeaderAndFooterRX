//
//  MapsViewController.swift
//  HeaderandFooterTraining
//
//  Created by brq on 21/02/2019.
//  Copyright © 2019 brq. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class MapsViewController: UIViewController {

    
    var locationManager = CLLocationManager()
    var currentLocation : CLLocation?
    var mapView : GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var likeyPlaces: [GMSPlace] = []
    var selectPlace: GMSPlace?
    let defaultLocation = CLLocation(latitude: -33.869405, longitude: 151.199)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        var rightButton = UIBarButtonItem(title: "Get Place", style: .plain, target: self, action: #selector(putMarker))
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        self.title = "teste"
    }

    func setupUI(){
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude , longitude:defaultLocation.coordinate.longitude, zoom: zoomLevel)
        
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
        mapView.isHidden = true
        mapView.isMyLocationEnabled = true
        listLikeyPlaces()
    }
    
    
    func listLikeyPlaces(){
        likeyPlaces.removeAll()
        placesClient.currentPlace { (placeLikehoods, error)-> Void in
            if let error  = error{
                print("Error",error)
            return
            }
            if let likelyhoodList  = placeLikehoods{
                for likehood in likelyhoodList.likelihoods{
                    let place = likehood.place
                    self.likeyPlaces.append(place)
                }
            }
        }
    }
    
    @objc func putMarker(){
        mapView.clear()
        if selectPlace != nil{
            let marker = GMSMarker(position: (self.selectPlace?.coordinate)!)
            marker.title = selectPlace?.name
            marker.snippet = selectPlace?.formattedAddress
            marker.map = mapView
        }
        listLikeyPlaces()
        changeView()
    }
    
    
   @objc func changeView(){
        let vc = PlacesViewController()
        vc.likeyPlaces = likeyPlaces
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



extension MapsViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations.last!
        print(location)
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        if mapView.isHidden{
            mapView.isHidden = false
            mapView.camera = camera
        }else{
            mapView.animate(to: camera)
        }
        
        listLikeyPlaces()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location is restricted")
        case .denied:
            print("User denied acess to locate")
        case .notDetermined:
            print("Location cannot be determinated")
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
        print("Location ok")
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}
