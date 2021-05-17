//
//  WeatherIcon.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import SnapKit
import UIKit
import Kingfisher

class WeatherIcon: UIView {
    
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
        
        guard let image = image, let url = Router.forIcon(image).completed() else { return }
        icon.kf.setImage(with: url)
        titleLabel.text = title
    }
    
    
    private func setupIcon() {
        addSubview(icon)
        addSubview(titleLabel)
         //icon.contentMode = .scaleAspectFit
        icon.layer.shadowOpacity = 0.3
        icon.layer.shadowOffset = .zero
        icon.layer.shadowRadius = 5
        icon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
//            make.bottom.equalTo(titleLabel.snp.top)
            make.width.height.equalTo(120)
        }
        titleLabel.snp.makeConstraints { make in
            //make.top.equalTo(icon.snp.bottom).inset(10)
            make.leading.equalTo(20)
        }
       
    }
    
}
