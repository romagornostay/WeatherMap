//
//  PlaceCardView.swift
//  WeatherMap
//
//  Created by SalemMacPro on 11.5.21.
//

import UIKit

final class PlaceCardView: UIView {
   private let placeLabel = UILabel()
   private let coordinateLabel = UILabel()
   private let showWeatherButton = UIButton(type: .system)
   private let closeButton = UIButton(type: .system)
    var buttonTapped: (() -> Void)?
    var closeTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ place: String, with coordinate: String) {
        placeLabel.text = place
        coordinateLabel.text = coordinate
    }
    
    @objc func showWeather() {
        buttonTapped?()
    }
    
    @objc func closeView() {
        closeTapped?()
    }
    
    private func setupLayout() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.base1.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 10
        
        addSubview(placeLabel)
        placeLabel.font = .base1
        placeLabel.textColor = .base1
        
        addSubview(coordinateLabel)
        coordinateLabel.font = .base2
        coordinateLabel.textColor = .base2
        
        addSubview(showWeatherButton)
        showWeatherButton.setTitle(LocalizationConstants.Map.showWeather, for: .normal)
        showWeatherButton.setTitleColor(.base3, for: .normal)
        showWeatherButton.layer.cornerRadius = 22
        showWeatherButton.layer.borderColor = UIColor.base3.cgColor
        showWeatherButton.layer.borderWidth = 1
        showWeatherButton.addTarget(self, action: #selector(showWeather), for: .touchUpInside)
        
        addSubview(closeButton)
        closeButton.setImage(Images.closeButton, for: .normal)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        placeLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(16)
        }
        coordinateLabel.snp.makeConstraints { make in
            make.leading.equalTo(placeLabel)
            make.top.equalTo(placeLabel.snp.bottom).offset(2)
        }
        showWeatherButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-13)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.trailing.equalTo(-20)
        }
    }
}
