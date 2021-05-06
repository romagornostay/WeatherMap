//
//  WeatherViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 4.5.21.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    
    weak var coordinator: MainCoordinator? 
    
    let frameView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mist")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 50
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupViews()
    }
    
    func setup() {
        
        view.backgroundColor = .secondarySystemBackground
        title = "Milan"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupViews() {
        
        view.addSubview(frameView)
        frameView.addSubview(imageView)

        
        frameView.snp.makeConstraints { (make) in
            make.width.height.equalTo(761)
            make.top.equalTo(91)
            make.left.equalTo(135)
        }
        imageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
        }
    }
}
