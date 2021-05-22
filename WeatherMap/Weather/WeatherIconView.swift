//
//  WeatherIconView.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import SnapKit
import UIKit
import Kingfisher

class WeatherIconView: UIView {
    private let icon = UIImageView()
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .base4
        label.font = .base4
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configIcon(image: String?, title: String?) {
        guard let image = image, let url = URLRouter.forIcon(image).completed() else { return }
        icon.kf.setImage(with: url)
        titleLabel.text = title
    }
    
    
    private func setupIcon() {
        addSubview(icon)
        addSubview(titleLabel)
        icon.contentMode = .scaleAspectFill
        icon.layer.shadowOpacity = 0.5
        icon.layer.shadowRadius = 5
        icon.layer.shadowOffset = .zero
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(-15)
            make.leading.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(icon.snp.centerX)
            make.bottom.equalTo(icon.snp.bottom)
            make.leading.equalTo(-5)
        }
    }
}
