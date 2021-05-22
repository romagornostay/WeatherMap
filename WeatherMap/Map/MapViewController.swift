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
    private let viewModel: MapViewModel
    private let loaderView = UIActivityIndicatorView(style: .medium)
    private let mapView = MKMapView()
    private let cardView = PlaceCardView()
    private let resultsVC = SearchResultsViewController()
    private lazy var searchController = UISearchController(searchResultsController: resultsVC)
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        setupLayout()
        setupMapView()
        setupCard()
        setupLoader()
    }
    
    private func binding() {
        viewModel.onDidStartLoading = { [weak self] in
            self?.loaderView.startAnimating()
        }
        viewModel.onDidSetupCard = { [weak self] in
            guard let location = self?.viewModel.location else { return }
            self?.addMapPin(location: location.coordinate)
            self?.showCard()
        }
        viewModel.onDidHideCard = { [weak self] in
            self?.hideCard()
        }
        viewModel.onDidEndLoading = { [weak self] in
            self?.loaderView.stopAnimating()
        }
    }
    
    private func addMapPin(location: CLLocationCoordinate2D){
        mapView.removeAnnotations(mapView.annotations)
        let pin = MKPointAnnotation()
        pin.coordinate = location
        mapView.addAnnotation(pin)
    }
    
    private func setupLayout() {
        title = LocalizationConstants.Map.title
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 1
        navigationController?.navigationBar.layer.shadowOffset = .zero
        navigationController?.navigationBar.layer.shadowRadius = 10
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
            make.edges.equalToSuperview()
        }
        mapView.mapType = .standard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
        startFromEurope()
    }
    
    private func startFromEurope() {
        let latitude = CLLocationDegrees(Constants.Location.latitude)
        let longitude = CLLocationDegrees(Constants.Location.longitude)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        defaultZoom(coordinate: coordinate)
    }
    
    private func defaultZoom(coordinate: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func setupCard() {
        mapView.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.snp.makeConstraints { (make) in
            make.height.equalTo(154)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(200)
        }
        cardView.buttonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.showWeather()
        }
        cardView.closeTapped = { [weak self] in
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
            mapView.setCenter(location, animated: true)
        }
    }
    
    private func setupLoader() {
        mapView.addSubview(loaderView)
        mapView.bringSubviewToFront(loaderView)
        loaderView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func showCard() {
        if let place = viewModel.place, let coordinate = viewModel.coordinate {
            cardView.configure(place, with: coordinate)
            UIView.animate(withDuration: 0.2) {
                self.cardView.snp.remakeConstraints { make in
                    make.height.equalTo(154)
                    make.leading.equalTo(16)
                    make.trailing.equalTo(-16)
                    make.bottomMargin.equalTo(-25)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func hideCard() {
        UIView.animate(withDuration: 0.3) {
            self.cardView.snp.remakeConstraints { make in
                make.height.equalTo(154)
                make.leading.equalTo(16)
                make.trailing.equalTo(-16)
                make.bottom.equalTo(200)
            }
            self.view.layoutIfNeeded()
        }
    }
}
// MARK: SearchResultsViewControllerDelegate
extension MapViewController: SearchResultsViewControllerDelegate {
    func searchResultsViewController(_ vc: SearchResultsViewController, didSelectLocationWith coordinate: CLLocationCoordinate2D?) {
        guard let coordinate = coordinate else { return }
        viewModel.findLocality(coordinate: coordinate)
        searchController.dismiss(animated: true) {
            self.defaultZoom(coordinate: coordinate)
        }
    }
}
