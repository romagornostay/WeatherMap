//
//  WeatherDetail.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import UIKit
import SnapKit

class WeatherDetail: UIView {
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .base4
        label.font = .base6
        return label
    }()
    
    private let infoLabel: UILabel = {
        var label = UILabel()
        label.textColor = .base4
        label.font = .base5
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func configure(title: String, description: String) {
        titleLabel.text = title
        infoLabel.text = description
    }
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(infoLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
        }
    }
}
