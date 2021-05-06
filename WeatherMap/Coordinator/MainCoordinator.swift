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
        let vc = MapViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    func showDeatailWeather() {
        let vc = WeatherViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
