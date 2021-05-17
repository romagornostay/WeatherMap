//
//  WeatherViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 4.5.21.
//

import UIKit
import SnapKit


final class WeatherViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    private var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let icon = WeatherIcon()
    private let humidity = WeatherDetail()
    private let windView = WeatherDetail()
    private let pressure = WeatherDetail()
    private let imageView = UIImageView()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base5
        label.font = .base7
        return label
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [temperatureLabel, icon, humidity, windView, pressure])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.getData()
        setup()
        binding()
        setupLayout()
        setupViews()
        
    }
    
    private func binding() {
        viewModel.updateView = { [weak self] in
            guard let self = self else { return }
            let data = self.viewModel.currentWeather
            self.setupData(currentWeather: data)
            
            guard let error = self.viewModel.responseError else { return }
            self.showError(networkError: error) { [weak self] in
                self?.viewModel.retry()
            }
        }
    }
    
    func setup() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupData(currentWeather: CurrentWeather) {
        let currentWeather = currentWeather
        let mainValue = currentWeather.mainValue
        let iconData = currentWeather.elements.first
        let wind = currentWeather.wind
        title = currentWeather.name
        
        temperatureLabel.text = "\(Temperature.conversionToC(mainValue.temp))˚"
        icon.configIcon(image: iconData?.icon, title: iconData?.description.capitalized)
        humidity.configure(title: LocalizationConstants.Weather.humidity, description: "\(mainValue.humidity) %")
        windView.configure(title: LocalizationConstants.Weather.wind, description: "\(Wind.getDeg(deg:wind.deg)) \(wind.speed) \(LocalizationConstants.Weather.windMeasurement)")
        pressure.configure(title: LocalizationConstants.Weather.pressure, description: "\(Pressure.mmHg(mainValue.pressure)) \(LocalizationConstants.Weather.pressureMeasurement)")
        
        if let image = UIImage(named: iconData!.description) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "scattered clouds")
        }
    }
    
    func setupLayout() {
        view.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { (make) in
            make.topMargin.left.equalTo(20)
            make.bottom.equalTo(-5)
        }
        
    }
    
    func setupViews() {
        
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        let mask = CALayer()
        mask.contents = UIImage(named: "mask")?.cgImage
        mask.frame = CGRect(x: 0, y: 0, width: 240, height: 580)
        imageView.layer.mask = mask
        imageView.layer.masksToBounds = true
        
        imageView.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
        }
    }
    
    func showError(networkError: ResponseError, completion: @escaping () -> ()) {
      let errorView = ErrorView(responseError: networkError)
      errorView.refresh = { [weak errorView] in
        errorView?.removeFromSuperview()
        completion()
      }
      view.addSubview(errorView)
    }
}
