//
//  WeatherViewController.swift
//  WeatherMap
//
//  Created by SalemMacPro on 4.5.21.
//

import UIKit
import SnapKit


final class WeatherViewController: UIViewController {
    //weak var coordinator: MainCoordinator?
    
  lazy var viewModel = WeatherViewModel(city: place)
    
    var place: String?
    
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base4
        label.font = .base7
        label.numberOfLines = 1
        return label
    }()
    
    let humidityTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base4
        label.font = .base6
        label.numberOfLines = 1
        return label
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base4
        label.font = .base5
        label.numberOfLines = 1
        return label
    }()
    
    let windTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base4
        label.font = .base6
        label.numberOfLines = 1
        return label
    }()
    
    let windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base4
        label.font = .base5
        label.numberOfLines = 1
        return label
    }()
    
    let pressureTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base4
        label.font = .base6
        label.numberOfLines = 1
        return label
    }()
    
    let pressureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base4
        label.font = .base5
        label.numberOfLines = 1
        return label
    }()
    
    let frameView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "mist")
        view.contentMode = .scaleAspectFit
        let mask = CALayer()
        mask.contents = UIImage(named: "mask")?.cgImage
        mask.frame = CGRect(x: 0, y: 0, width: 240, height: 580)
        view.layer.mask = mask
        view.layer.masksToBounds = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getData()
        setup()
        setupViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupData()
        setupLayout()
    }
    
    func setup() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupData() {
        title = viewModel.currentWeather.name
        temperatureLabel.text = "\(viewModel.currentWeather.mainValue.temp) ˚"
        humidityTitleLabel.text = "humidity".uppercased()
        humidityLabel.text = "\(viewModel.currentWeather.mainValue.humidity) %"
        windTitleLabel.text = "wind".uppercased()
        windLabel.text = "\(viewModel.currentWeather.wind.speed) m/s"
        pressureTitleLabel.text = "pressure".uppercased()
        pressureLabel.text = "\(viewModel.currentWeather.mainValue.pressure) mm Hg"
    }
    
    func setupLayout() {
        view.addSubview(contentView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(humidityTitleLabel)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(windTitleLabel)
        contentView.addSubview(windLabel)
        contentView.addSubview(pressureTitleLabel)
        contentView.addSubview(pressureLabel)
        
        
        
        contentView.snp.makeConstraints { make in
            make.edges.width.height.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(132)
            make.leading.equalTo(contentView).inset(16)
        }
        
        humidityTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).inset(16)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).inset(16)
        }
        
        windTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(40)
            make.leading.equalTo(contentView).inset(16)
        }
        
        windLabel.snp.makeConstraints { make in
            make.top.equalTo(windTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).inset(16)
        }
        
        pressureTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(windLabel.snp.bottom).offset(40)
            make.leading.equalTo(contentView).inset(16)
        }
        
        pressureLabel.snp.makeConstraints { make in
            make.top.equalTo(pressureTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).inset(16)
        }
        
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
