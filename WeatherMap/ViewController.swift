//
//  ViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 3.5.21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.6, alpha: 0.4)
        view.layer.cornerRadius = 20
       return view
    }()
    
    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.layer.cornerRadius = 20
       return view
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 20
       return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 20
       return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView, bottomView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
      return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupViews()
    }
    
    func setup (){
        view.backgroundColor = .brown
        title = "Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupViews() {
        
        view.addSubview(mainView)
        mainView.addSubview(subView)
        subView.addSubview(mainStackView)
        
        mainView.snp.makeConstraints { (make) in
            make.topMargin.left.equalTo(16)
            make.right.bottom.equalTo(-16)
        }
        subView.snp.makeConstraints { (make) in
            make.width.height.equalTo(300)
            make.center.equalTo(self.mainView)
        }
        mainStackView.snp.makeConstraints { (make) in
            make.top.left.equalTo(20)
            make.right.bottom.equalTo(-20)
        }
    }

}
