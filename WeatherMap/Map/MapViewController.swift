//
//  MapViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 11.5.21.
//

import UIKit
import SnapKit
import MapKit

class MapViewController: UIViewController {
    weak var coordinator: MapCoordinator?
    
    
    var viewModel = MapViewModel()
    let placeCardView = PlaceCardView()
    private let searchController = UISearchController()
    private let mapView = MKMapView()
    let placeLabel = UILabel()
    let coordinateLabel = UILabel()
    let showWeatherButton = UIButton(type: .system)
    
    let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.base5.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 16
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        title = "Global Weather"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: nil)
        setupNavigationItem()
        setupMapView()
        setupNameView()
        setupPlaceLabel()
        setupCoordinateLabel()
        setupShowWeatherButton()
    }
    
    private func setupNavigationItem() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func findLocation() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        
        print(" tap on screen")
        if sender.state == .ended {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            let location2D = CLLocation(latitude: locationOnMap.latitude, longitude: locationOnMap.longitude)
            viewModel.findPlace(with: location2D )
            addAnnotation(location: locationOnMap)
        }
    }
    
    func addAnnotation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = viewModel.city
        annotation.subtitle = viewModel.stringCoord
        self.mapView.addAnnotation(annotation)
        
        
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.right.bottom.equalTo(0)
        }
        mapView.mapType = .standard
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        let latitude = CLLocationDegrees(45)
        let longitude = CLLocationDegrees(15)
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func setupNameView() {
        view.addSubview(nameView)
        
        nameView.snp.makeConstraints { (make) in
            make.width.equalTo(343)
            make.height.equalTo(154)
            make.left.equalTo(16)
            make.bottom.equalTo(-16)
        }
    }
    
    
    func setupPlaceLabel() {
        nameView.addSubview(placeLabel)
        
        placeLabel.text = viewModel.city
        placeLabel.font = .base1
        placeLabel.textColor = .base1
        
        placeLabel.snp.makeConstraints { make in
            make.left.top.equalTo(16)
        }
    }
    
    func setupCoordinateLabel() {
        nameView.addSubview(coordinateLabel)
        
        coordinateLabel.text = viewModel.stringCoord
        coordinateLabel.font = .base2
        coordinateLabel.textColor = .base2
        
        coordinateLabel.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(placeLabel).inset(22)
        }
    }
    
    @objc func showWeather() {
        print("Show Weather")
        coordinator?.showWeather(city: viewModel.city!)
    }
    
    func setupShowWeatherButton() {
        
        nameView.addSubview(showWeatherButton)
        showWeatherButton.setTitle("Show Weather", for: .normal)
        showWeatherButton.setTitleColor(.base3, for: .normal)
        showWeatherButton.layer.cornerRadius = 22
        showWeatherButton.layer.borderWidth = 1
        showWeatherButton.layer.borderColor = UIColor.base3.cgColor
        showWeatherButton.addTarget(self, action: #selector(showWeather), for: .touchUpInside)
        
        showWeatherButton.snp.makeConstraints { make in
            make.leading.equalTo(placeLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
    }
}

extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.updateSearchResults(text: text)
    }
}

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.rightCalloutAccessoryView = UIButton(type: .infoLight)
            pinView!.pinTintColor = UIColor.green
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if (view.annotation?.title!) != nil {
                print("do something")
            }
        }
    }
}

