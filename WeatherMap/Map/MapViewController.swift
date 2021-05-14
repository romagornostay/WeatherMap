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
    
    weak var coordinator: MainCoordinator?
    private var viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mapView = MKMapView()
    private let card = PlaceCardView()
    let resultsVC = SearchResultsViewController()
    lazy var searchController = UISearchController(searchResultsController: resultsVC)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self
        setupNavigationItems()
        setupMapView()
        setupCard()
    }
    
    private func setupNavigationItems() {
        title = "Global Weather"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: nil)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = resultsVC
        resultsVC.delegate = self
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
        //      let latitude = CLLocationDegrees(50)
        //      let longitude = CLLocationDegrees(10)
        //      let coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
        //                                                latitudinalMeters: 2000000, longitudinalMeters: 2000000)
        //      mapView.setRegion(coordinateRegion, animated: true)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        self.mapView.removeAnnotations(self.mapView.annotations)
        if sender.state == .ended {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
            
        }
    }
    
    private func setupCard() {
        
        mapView.addSubview(card)
        card.backgroundColor = .systemBackground
        
        card.snp.makeConstraints { (make) in
            make.width.equalTo(343)
            make.height.equalTo(154)
            make.left.equalTo(16)
            make.bottom.equalTo(200)
        }
        card.buttonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.showWeather()
        }
        card.closeTapped = { [weak self] in
            guard let self = self else { return }
            self.hideView()
        }
    }
    func addAnnotation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        viewModel.stringCoord = clLocation.dms
        LocationManager.shared.resolveLocationName(with: clLocation) { [weak self] locationName in
            guard let locality = locationName else { return }
            self?.viewModel.place = locality
            !locality.isEmpty ? self?.showLocationView() : self?.hideView()
            
        }
    }
    private func showLocationView() {
        if let place = viewModel.place, let coordinate = viewModel.stringCoord {
            card.configCard(city: place, coordinate: coordinate)
            UIView.animate(withDuration: 0.2) {
                self.card.snp.remakeConstraints { make in
                    make.width.equalTo(343)
                    make.height.equalTo(154)
                    make.left.equalTo(16)
                    make.bottom.equalTo(-16)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func hideView() {
        UIView.animate(withDuration: 0.5) {
            self.card.snp.remakeConstraints { make in
                make.width.equalTo(343)
                make.height.equalTo(154)
                make.left.equalTo(16)
                make.bottom.equalTo(200)
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension MapViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewController(_ vc: SearchResultsViewController, didSelectLocationWith coordinates: CLLocationCoordinate2D?) {
        guard let coordinates = coordinates else { return }
        searchController.dismiss(animated: true) {
            self.mapView.removeAnnotations(self.mapView.annotations)
            let pin = MKPointAnnotation()
            pin.coordinate = coordinates
            self.mapView.addAnnotation(pin)
        }
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: true)
    }
}
