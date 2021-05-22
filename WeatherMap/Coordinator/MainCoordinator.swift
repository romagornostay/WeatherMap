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
        let mapViewController = MapViewController(viewModel: viewModel)
        mapViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(mapViewController, animated: false)
    }
}

extension MainCoordinator: MapViewModelDelegate {
    func showWeather(place: String) {
        let viewModel = WeatherViewModel(place: place)
        let weatherViewController = WeatherViewController(viewModel: viewModel)
        weatherViewController.navigationItem.largeTitleDisplayMode = .always
        navigationController.pushViewController(weatherViewController, animated: true)
    }
}
