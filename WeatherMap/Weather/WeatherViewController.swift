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
        //view.backgroundColor = .systemBackground
        return view
    }()
    
    let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .base4
        label.font = .base6
        label.numberOfLines = 1
        return label
    }()
    
    private  let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
        let cw = viewModel.sendData()
        let description = cw.elements.first?.description
        title = cw.name
        
        temperatureLabel.text = "\(Int(cw.mainValue.temp - 273.15))˚"
        descriptionTitleLabel.text = description?.capitalized
        humidityTitleLabel.text = "humidity".uppercased()
        humidityLabel.text = "\(cw.mainValue.humidity) %"
        windTitleLabel.text = "wind".uppercased()
        windLabel.text = "\(Wind.getDeg(deg:cw.wind.deg)) \(cw.wind.speed) m/s"
        pressureTitleLabel.text = "pressure".uppercased()
        pressureLabel.text = "\(cw.mainValue.pressure) mm Hg"
        
        if let image = UIImage(named: description!) {
          imageView.image = image
        } else {
          imageView.image = UIImage(named: "scattered clouds")
        }
        //imageView.image = UIImage(named: description!)
    }
    
    func setupLayout() {
        view.addSubview(contentView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(descriptionTitleLabel)
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
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView).inset(16)
        }
        
        humidityTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(10)
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
        imageView.contentMode = .scaleAspectFit
        let mask = CALayer()
        mask.contents = UIImage(named: "mask")?.cgImage
        mask.frame = CGRect(x: 0, y: 0, width: 240, height: 580)
        imageView.layer.mask = mask
        imageView.layer.masksToBounds = true
        
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
