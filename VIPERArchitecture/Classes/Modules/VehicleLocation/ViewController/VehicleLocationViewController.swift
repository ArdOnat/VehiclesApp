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
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    fileprivate let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        return manager
    }()
    
    var window:UIWindow?
    var mapView = MKMapView()
    var vSpinner : UIView?
    var panGesture: UIPanGestureRecognizer?
    var presenter: VehicleLocationViewToPresenterProtocol?
    var vehicleList = [VehicleModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestureRecognizer()
        setupUI()
        setupDelegation()
        configure()
    }
    
    func setupUI() {
        navigationItem.title = ConstantStrings.map
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.white
        
        if let window = self.window {
            self.mapView = MKMapView(frame: CGRect(x: 0,y: 20, width: (window.frame.width), height: (window.frame.height)))
            self.view.addSubview(self.mapView)
        }
        
        mapView.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        mapView.showsUserLocation = true
    }
    
    private func setupDelegation() {
        self.locationManager.delegate = self
        
        mapView.delegate = self
        
        if let panGesture = panGesture {
            panGesture.delegate = self
            mapView.addGestureRecognizer(panGesture)
        }
    }
    
    private func setupGestureRecognizer() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(VehicleLocationViewController.didDragMap(_:)))
    }
    
    private func configure() {
        let countryCoordinate = CountryCoordinate(p2Lat: Float(mapView.northEastCoordinate.latitude), p1Lon:Float(mapView.southWestCoordinate.longitude), p1Lat: Float(mapView.southWestCoordinate.latitude), p2Lon: Float(mapView.northEastCoordinate.longitude))
        activityIndicator.startAnimating()
        presenter?.viewDidLoad(countryCoordinate: countryCoordinate)
    }
    
}

extension VehicleLocationViewController: VehicleLocationPresenterToViewProtocol {
    
    func onFetchVehiclesSuccess() {
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
                self.mapView.addAnnotation(annotation)
            }
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    func onFetchVehiclesFailure(error: String) {
        print("Error occured while fetching vehicles. Error: \(error)")
        self.activityIndicator.stopAnimating()
    }
    
}

extension VehicleLocationViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = ConstantStrings.annotation
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func didDragMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let countryCoordinate = CountryCoordinate(p2Lat: Float(mapView.northEastCoordinate.latitude), p1Lon:Float(mapView.southWestCoordinate.longitude), p1Lat: Float(mapView.southWestCoordinate.latitude), p2Lon: Float(mapView.northEastCoordinate.longitude))
            activityIndicator.startAnimating()
            presenter?.getVehicles(countryCoordinate: countryCoordinate)
        }
    }
    
}

extension VehicleLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let currentLocation = location.coordinate
        let coordinateRegion = MKCoordinateRegion(center: currentLocation, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(coordinateRegion, animated: true)
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
