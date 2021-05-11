//
//  WeatherCoordinator.swift
//  WeatherMap
//
//  Created by SalemMacPro on 11.5.21.
//

import Foundation
import UIKit

final class WeatherCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private var city: String

    init(navigationController: UINavigationController, city: String) {
        self.navigationController = navigationController
        self.city = city
    }
    
    
    func start() {
        let vc = WeatherViewController()
        let viewModel = WeatherViewModel(city: city)
        //let viewModel = WeatherViewModel()
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}

