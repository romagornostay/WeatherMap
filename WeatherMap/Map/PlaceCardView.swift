//
//  PlaceCardView.swift
//  WeatherMap
//
//  Created by SalemMacPro on 11.5.21.
//

import Foundation
import UIKit

final class PlaceCardView: UIView {
    
    let placeLabel = UILabel()
    let coordinateLabel = UILabel()
    let showWeatherButton = UIButton(type: .system)
    var buttonTapped: (() -> Void)?
    let closeButton = UIButton(type: .system)
    var closeTapped: (() -> Void)?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setCardWith(city: String, coordinate: String) {
        placeLabel.text = city
        coordinateLabel.text = coordinate
    }
    
    func setupLayout() {
        setupLayer()
        setupPlaceLabel()
        setupCoordinateLabel()
        setupShowWeatherButton()
        setupCloseCardViewButton()
    }
    
    func setupLayer() {
        
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.base5.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 16
        layer.cornerCurve = .continuous
    }
    
    func setupPlaceLabel() {
        
        addSubview(placeLabel)
        placeLabel.font = .base1
        placeLabel.textColor = .base1
        
        placeLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
        }
    }
    
    func setupCoordinateLabel() {
        
        addSubview(coordinateLabel)
        coordinateLabel.font = .base2
        coordinateLabel.textColor = .base2
        
        coordinateLabel.snp.makeConstraints { make in
            make.leading.equalTo(placeLabel)
            make.top.equalTo(placeLabel.snp.bottom).offset(2)
        }
    }
    
    @objc func showWeather() {
        print("Show Weather")
        buttonTapped?()
    }
    
    func setupShowWeatherButton() {
        
        addSubview(showWeatherButton)
        showWeatherButton.setTitle("Show Weather", for: .normal)
        showWeatherButton.setTitleColor(.base3, for: .normal)
        showWeatherButton.layer.cornerRadius = 22
        showWeatherButton.layer.borderWidth = 1
        //showWeatherButton.layer.borderColor = UIColor.base3.cgColor
        showWeatherButton.addTarget(self, action: #selector(showWeather), for: .touchUpInside)
        
        showWeatherButton.snp.makeConstraints { make in
            make.leading.equalTo(placeLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
    }
    
    @objc func closeView() {
        closeTapped?()
    }
    
    func setupCloseCardViewButton() {
        
        addSubview(closeButton)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(-20)
        }
    }
}
