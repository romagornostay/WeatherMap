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
    private let searchController = UISearchController()
    private let card = PlaceCardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self
        setup()
        setupLayout()
        //findLocation()
    }
    
    func setup() {
        view.backgroundColor = .brown
        title = "Global Weather"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Map", style: .plain, target: self, action: nil)
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        
        view.addSubview(mapView)
        mapView.addSubview(card)
        card.backgroundColor = .systemBackground
        
        mapView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.right.bottom.equalTo(0)
        }
        
        card.snp.makeConstraints { (make) in
            make.width.equalTo(343)
            make.height.equalTo(154)
            make.left.equalTo(16)
            make.bottom.equalTo(-16)
        }
        card.buttonTapped = { [weak self] in
          guard let self = self else { return }
          //self.viewModel?.showWeather()
        }
        card.closeTapped = { [weak self] in
          guard let self = self else { return }
          self.hideView()
        }
    }
    private func showLocationView() {
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
