//
//  ErrorView.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import UIKit
import SnapKit

final class ErrorView: UIView {
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = .base7
        label.font = .base8
        label.textAlignment = .center
        return label
    }()
    private let subtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .base5
        label.font = .base3
        label.textAlignment = .center
        return label
    }()
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(LocalizationConstants.RefreshButton.title, for: .normal)
        button.setTitleColor(.base3, for: .normal)
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.base3.cgColor
        return button
    }()
    
    var refresh: (() -> Void)?
    
    convenience init(responseError: ResponseError, frame: CGRect) {
        self.init(frame: frame)
        setupText(for: responseError)
        setupLayout()
    }
    
    convenience init(responseError: ResponseError) {
        self.init()
        setupText(for: responseError)
        setupLayout()
    }
    
    @objc
    private func refreshAction() {
        refresh?()
    }
    
    private func setupText(for error: ResponseError) {
        switch error {
        case .keyError:
            title.text = LocalizationConstants.KeyError.title
            subtitle.text = LocalizationConstants.KeyError.subtitle
        case .noInternet:
            title.text = LocalizationConstants.NoInternet.title
            subtitle.text = LocalizationConstants.NoInternet.subtitle
        case .serverResponse:
            title.text = LocalizationConstants.SomethingWentWrong.title
            subtitle.text = LocalizationConstants.SomethingWentWrong.subtitle
        }
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubview(subtitle)
        subtitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.bottom.equalTo(subtitle.snp.top).offset(-16)
            make.leading.trailing.equalTo(subtitle)
        }
        
        addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(subtitle.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(44)
        }
        refreshButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
    }
}
