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
    
    private func dafaultZoom(coordinate: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        setupNavigationItems()
        setupMapView()
        setupCard()
    }
    
    private func binding() {
        viewModel.setupCard = { [weak self] in
            guard let self = self else { return }
            guard let location = self.viewModel.location else { return }
            self.addMapPin(location: location.coordinate)
            self.showCard()
        }
        viewModel.hideCard = { [weak self] in
            guard let self = self else { return }
            self.hideCard()
        }
    }
    
    private func setupNavigationItems() {
        title = LocalizationConstants.Map.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: LocalizationConstants.Map.backItem, style: .plain, target: self, action: nil)
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
        
        let latitude = CLLocationDegrees(LocalizationConstants.Location.latitude)
        let longitude = CLLocationDegrees(LocalizationConstants.Location.longitude)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        dafaultZoom(coordinate: coordinate)
        
    }
    
    private func setupCard() {
        
        mapView.addSubview(card)
        card.backgroundColor = .white
        card.snp.makeConstraints { (make) in
            make.height.equalTo(154)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(200)
        }
        card.buttonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.showWeather()
        }
        card.closeTapped = { [weak self] in
            guard let self = self else { return }
            self.hideCard()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer){
        mapView.removeAnnotations(mapView.annotations)
        viewModel.cleanCard()
        if sender.state == .ended {
            let locationInView = sender.location(in: mapView)
            let location = mapView.convert(locationInView, toCoordinateFrom: mapView)
            
            viewModel.findLocality(coordinate: location)
        }
    }
    
    func addMapPin(location: CLLocationCoordinate2D){
        self.mapView.removeAnnotations(self.mapView.annotations)
        let pin = MKPointAnnotation()
        pin.coordinate = location
        mapView.addAnnotation(pin)
    }
    
    private func showCard() {
        if let place = viewModel.place, let coordinate = viewModel.coordinate {
            card.configCard(city: place, coordinate: coordinate)
            UIView.animate(withDuration: 0.2) {
                self.card.snp.remakeConstraints { make in
                    //make.width.equalTo(343)
                    make.height.equalTo(154)
                    make.left.equalTo(16)
                    make.right.equalTo(-16)
                    make.bottomMargin.equalTo(-20)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func hideCard() {
        UIView.animate(withDuration: 0.3) {
            self.card.snp.remakeConstraints { make in
                make.height.equalTo(154)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.bottom.equalTo(200)
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension MapViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewController(_ vc: SearchResultsViewController, didSelectLocationWith coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else { return }
        
        viewModel.findLocality(coordinate: coordinate)
        
        searchController.dismiss(animated: true) {
            self.dafaultZoom(coordinate: coordinate)
        }
    }
}
