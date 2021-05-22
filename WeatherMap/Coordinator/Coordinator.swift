//
//  Coordinator.swift
//  WeatherMap
//
//  Created by SalemMacPro on 6.5.21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set}
}
