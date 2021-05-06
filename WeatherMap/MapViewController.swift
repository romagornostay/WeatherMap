//
//  MapViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 3.5.21.
//

import UIKit
import SnapKit
import MapKit


class MapViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    lazy var searchController: UISearchController = {
      let searchController = UISearchController()
      searchController.searchBar.autocapitalizationType = .none
      searchController.obscuresBackgroundDuringPresentation = false
      return searchController
    }()
    
    let nameView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Milan"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let coordinate: UILabel = {
        let label = UILabel()
        label.text = "45°16'44.7\"N 9°43'33.2\"E"
        label.textColor = UIColor(red: 0.674, green: 0.674, blue: 0.674, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let showWeatherButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Weather", for: .normal)
        button.setTitleColor(UIColor(red: 0.29, green: 0.565, blue: 0.886, alpha: 1), for: .normal)
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.29, green: 0.565, blue: 0.886, alpha: 1).cgColor
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonTapped() {
        coordinator?.showDeatailWeather()
        print("Show Weather")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupSearchController()
        setupViews()
    }
    
    func setup() {
        
        view.backgroundColor = .brown
        title = "Global Weather"
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupSearchController() {
        
      definesPresentationContext = true
      navigationItem.hidesSearchBarWhenScrolling = false
      navigationItem.searchController = self.searchController
    }
    
    func setupViews() {
        
        view.addSubview(mapView)
        mapView.addSubview(nameView)
        nameView.addSubview(nameLabel)
        nameView.addSubview(coordinate)
        nameView.addSubview(showWeatherButton)
        
        
        mapView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.right.bottom.equalTo(0)
        }
        nameView.snp.makeConstraints { (make) in
            make.width.equalTo(343)
            make.height.equalTo(154)
            make.left.equalTo(16)
            make.bottom.equalTo(-16)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(16)
        }
        coordinate.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(nameLabel).inset(22)
        }
        
        showWeatherButton.snp.makeConstraints { (make) in
            make.width.equalTo(311)
            make.height.equalTo(44)
            make.left.equalTo(16)
            make.bottom.equalTo(-13)
        }
        
    }
   
}
