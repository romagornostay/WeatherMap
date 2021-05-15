//
//  MainCoordinator.swift
//  WeatherMap
//
//  Created by SalemMacPro on 6.5.21.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showMap() {
        let viewModel = MapViewModel()
        viewModel.delegate = self
        let vc = MapViewController(viewModel: viewModel)
        vc.navigationItem.largeTitleDisplayMode = .never
        //vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
}

extension MainCoordinator: MapViewModelDelegate {
    func showWeather(place: String) {
        let viewModel = WeatherViewModel(place: place)
        let vc = WeatherViewController(viewModel: viewModel)
        vc.navigationItem.largeTitleDisplayMode = .always
        //vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
