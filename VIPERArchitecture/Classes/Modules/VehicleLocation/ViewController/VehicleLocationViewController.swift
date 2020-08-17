//
//  VehicleLocationViewController.swift
//  CaseProject
//
//  Created by Arda Onat on 17.08.2020.
//  Copyright © 2020 Arda Onat. All rights reserved.
//

import UIKit
import MapKit

class VehicleLocationViewController: UIViewController {
    
    var window:UIWindow?
    var mapView: MKMapView?
    
    var presenter: VehicleLocationViewToPresenterProtocol?
    var vehicleList = [VehicleModel]()
    
    fileprivate let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegation()
        
        if let mapView = mapView {
            let countryCoordinate = CountryCoordinate(p2Lat: Float(mapView.northEastCoordinate.latitude), p1Lon:Float(mapView.southWestCoordinate.longitude), p1Lat: Float(mapView.southWestCoordinate.latitude), p2Lon: Float(mapView.northEastCoordinate.longitude))
            presenter?.viewDidLoad(countryCoordinate: countryCoordinate)
        }
    }
    
    private func setupUI() {
        
        navigationItem.title = "Map"
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        
        self.mapView = MKMapView(frame: CGRect(x: 0,y: 20, width: (self.window?.frame.width)!, height: (self.window?.frame.height)!))
        self.view.addSubview(self.mapView!)
        
    }
    
    private func setupDelegation() {
        
        mapView?.delegate = self
        
        // add pan gesture to detect when the map moves
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap(_:)))

        // make your class the delegate of the pan gesture
        panGesture.delegate = self
        
        // add the gesture to the mapView
        mapView?.addGestureRecognizer(panGesture)
    }
    
}

extension VehicleLocationViewController: VehicleLocationPresenterToViewProtocol {
    
    func onFetchVehiclesSuccess() {
        print("View receives the response from Presenter and updates itself.")
        DispatchQueue.main.async {
            guard let vehicleList = self.presenter?.vehicleList else {
                return
            }
            
            self.vehicleList = vehicleList
            
            for point in self.vehicleList {
                let annotation = MKPointAnnotation()
                annotation.title = point.type.rawValue
                annotation.subtitle = "\(point.id)"
                annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(point.coordinate.latitude), longitude: CLLocationDegrees(point.coordinate.longitude))
                self.mapView?.addAnnotation(annotation)
            }
        }
        //self.refreshControl.endRefreshing()
    }
    
    func onFetchVehiclesFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        //self.refreshControl.endRefreshing()
    }
    
    func showHUD() {
        //HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        //HUD.hide()
    }
    
}

extension VehicleLocationViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Identifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
    
}

extension VehicleLocationViewController: UIGestureRecognizerDelegate {
    
    // MARK: - Gesture functions
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func didDragMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            if let mapView = mapView {
                let countryCoordinate = CountryCoordinate(p2Lat: Float(mapView.northEastCoordinate.latitude), p1Lon:Float(mapView.southWestCoordinate.longitude), p1Lat: Float(mapView.southWestCoordinate.latitude), p2Lon: Float(mapView.northEastCoordinate.longitude))
                presenter?.onMapDragged(countryCoordinate: countryCoordinate)
            }
        }
    }
    
}

extension VehicleLocationViewController: CLLocationManagerDelegate {
    
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let location = locations.last! as CLLocation
      let currentLocation = location.coordinate
      let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
      mapView?.setRegion(coordinateRegion, animated: true)
      locationManager.stopUpdatingLocation()
   }
    
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print(error.localizedDescription)
   }
    
    func currentLocation() {
       locationManager.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
       if #available(iOS 11.0, *) {
          locationManager.showsBackgroundLocationIndicator = true
       } else {
          // Fallback on earlier versions
       }
       locationManager.startUpdatingLocation()
    }
    
}

