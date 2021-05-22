//
//  WeatherViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 4.5.21.
//

import UIKit
import SnapKit


final class WeatherViewController: UIViewController, ErrorShowingProtocol {
    private let viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let iconView = WeatherIconView()
    private let humidityView = WeatherDetailView()
    private let windView = WeatherDetailView()
    private let pressureView = WeatherDetailView()
    private let loaderView = UIActivityIndicatorView(style: .large)
    private let imageView = UIImageView()
    private let mask = CALayer()
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base5
        label.font = .base7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [temperatureLabel, iconView, humidityView, windView, pressureView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mask.frame = imageView.bounds
    }
    
    private func binding() {
        viewModel.loadWeather()
        viewModel.onDidUpdateData = { [weak self] weather in
            self?.setupData(weather)
        }
        viewModel.onDidReceiveError = { [weak self] error in
            self?.showError(error)
        }
        viewModel.onDidStartLoading = { [weak self] in
            self?.loaderView.startAnimating()
        }
        viewModel.onDidEndLoading = { [weak self] in
            self?.loaderView.stopAnimating()
        }
    }
    
    private func showError(_ network: ResponseError) {
        showError(network) { [weak self] in
            self?.viewModel.loadWeather()
        }
    }
    
    private func setupLayout() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.layer.shadowOpacity = 0.4
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(mainStackView)
        view.addSubview(loaderView)
        view.bringSubviewToFront(loaderView)
        loaderView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        mainStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(20)
            make.topMargin.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(91)
            make.leading.equalTo(135)
            make.trailing.bottom.equalToSuperview()
        }
        imageView.contentMode = .scaleAspectFill
        mask.contents = Images.mask?.cgImage
        imageView.layer.mask = mask
    }
    
    private func setupData(_ currentWeather: CurrentWeather) {
        title = currentWeather.name
        let mainValue = currentWeather.mainValue
        let iconData = currentWeather.elements.first
        let wind = currentWeather.wind
        
        if let image = UIImage(named: iconData!.description) {
            imageView.image = image
        } else {
            imageView.image = Images.defaultWeather
        }
        temperatureLabel.text = "\(Temperature.celsius(mainValue.temp))˚"
        iconView.configIcon(image: iconData?.icon, title: iconData?.description.capitalized)
        humidityView.configure(title: LocalizationConstants.Weather.humidity, description: "\(mainValue.humidity) %")
        windView.configure(title: LocalizationConstants.Weather.wind, description: "\(CardinalDirection.from(wind.deg)) \(wind.speed) \(LocalizationConstants.Weather.windMeasurement)")
        pressureView.configure(title: LocalizationConstants.Weather.pressure, description: "\(Pressure.mmHg(mainValue.pressure)) \(LocalizationConstants.Weather.pressureMeasurement)")
    }
}


