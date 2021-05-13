//
//  MainCoordinator.swift
//  WeatherMap
//
//  Created by SalemMacPro on 6.5.21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MapViewModel()
        let vc = MapViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    func showWeather(place: String) {
        let viewModel = WeatherViewModel(place: place)
        let vc = WeatherViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    
}
