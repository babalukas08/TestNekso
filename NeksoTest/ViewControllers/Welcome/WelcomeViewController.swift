//
//  WelcomeViewController.swift
//  NeksoTest
//
//  Created by Mauricio Jimenez on 06/10/18.
//  Copyright © 2018 com.MauJimenez. All rights reserved.
//

import UIKit
import MapKit

class WelcomeViewController: BaseViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var txtLabelWelcomeLabel: Heading!
    
    var idUserModel = ""
    var markerUsername = ""
    var locationAddress = ""
    let regionRadius: CLLocationDistance = 1000
    
    lazy var userModel: UserModel = {
       return UserModel()
    }()
    
    lazy var currentLocation : CLLocation = {
        return CLLocation()
    }()
    
    lazy var locManager : CLLocationManager = {
        return CLLocationManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configWelcomeView()
        mapView.delegate = self

        locManager.requestWhenInUseAuthorization()
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            if let currentLocationRequest = locManager.location {
                self.currentLocation = currentLocationRequest
                self.centerMapOnLocation(location: currentLocation)
                self.drawPinLocation(location: currentLocation)
                mapView.showsUserLocation = false
            }
        }
    }
    
    func configWelcomeView() {
        guard let userModelDB = DataSourceManager.getUserById(idUser: self.idUserModel) else {
            return
        }
        
        self.userModel = userModelDB
        self.txtLabelWelcomeLabel.text = userModel.getWelcomeText()
        self.markerUsername = "Location of " + userModel.username
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func drawPinLocation(location: CLLocation) {
        // show current on map
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Location name
            let locationName = placeMark.name ?? ""
            
            // City
            let city = placeMark.subAdministrativeArea ?? ""
            // Zip code
            let zip = placeMark.isoCountryCode ?? ""
            // Country
            let country = placeMark.country ?? ""
            
            self.locationAddress = locationName + ", " + city + ", " + zip + ", " + country
            let artwork = PinLocationModel(title: self.markerUsername,
                                           locationName: self.locationAddress,
                                           discipline: "",
                                           coordinate: location.coordinate)
            
            self.mapView.addAnnotation(artwork)
        })
        
        
    }
    
    func determineMyCurrentLocation() {
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.startUpdatingLocation()
        }
    }
}

extension WelcomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? PinLocationModel else { return nil }
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
        else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let modelInfo = InfoMapViewModel(userModel: self.userModel, location: self.locationAddress)
            self.showInputAlert(modelProgressAlertViewModel: modelInfo)
        }
    }
}

extension WelcomeViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        self.centerMapOnLocation(location: userLocation)
        self.drawPinLocation(location: userLocation)
        //manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
