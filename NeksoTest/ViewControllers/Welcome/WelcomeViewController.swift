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
    // set initial location in Honolulu
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)

    let regionRadius: CLLocationDistance = 1000
    lazy var locManager : CLLocationManager = {
        return CLLocationManager()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configWelcomeView()
        
        mapView.delegate = self

        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            self.centerMapOnLocation(location: currentLocation)
            self.drawPinLocation(location: currentLocation)
            
        }
    }
    
    func configWelcomeView() {
        guard let userModel = DataSourceManager.getUserById(idUser: self.idUserModel) else {
            return
        }
        
        self.txtLabelWelcomeLabel.text = userModel.getWelcomeText()
        self.markerUsername = "Location of " + userModel.username
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func drawPinLocation(location: CLLocation) {
        // show artwork on map
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
            
            let artwork = PinLocationModel(title: self.markerUsername,
                                           locationName: locationName + ", " + city + ", " + zip + ", " + country,
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
            //locationManager.startUpdatingHeading()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
}

extension WelcomeViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        self.centerMapOnLocation(location: userLocation)
        self.drawPinLocation(location: userLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
