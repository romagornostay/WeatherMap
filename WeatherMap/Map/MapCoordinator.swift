//
//  MapCoordinator.swift
//  WeatherMap
//
//  Created by SalemMacPro on 10.5.21.
//

import Foundation
import UIKit

final class MapCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MapViewController()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showWeather(city: String) {
        let coordinator = WeatherCoordinator(navigationController: navigationController, city: city)
        //let coordinator = WeatherCoordinator(navigationController: navigationController)

        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
