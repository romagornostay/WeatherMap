//
//  ErrorView.swift
//  WeatherMap
//
//  Created by SalemMacPro on 16.5.21.
//

import UIKit
import SnapKit

final class ErrorView: UIView {
    
    private let titleLabel = UILabel()
    private let subtitle = UILabel()
    private let refreshButton = UIButton(type: .system)
    var refresh: (() -> Void)?
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setupLayout()
    }
    
    convenience init(responseError: ResponseError) {
      self.init()
      setupText(network: responseError)
      setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func refreshAction() {
      refresh?()
    }
    
    private func setupText(network: ResponseError) {
      switch network {
      case .keyError:
        titleLabel.text = LocalizationConstants.KeyError.title
        subtitle.text = LocalizationConstants.KeyError.subtitle
      case .noInternet:
        titleLabel.text = LocalizationConstants.NoInternet.title
        subtitle.text = LocalizationConstants.NoInternet.subtitle
      case .serverResponse:
        titleLabel.text = LocalizationConstants.SomethingWentWrong.title
        subtitle.text = LocalizationConstants.SomethingWentWrong.subtitle
      }
    }
    
    
    
    private func setupLayout() {
        backgroundColor = .white
        
        
        addSubview(subtitle)
        subtitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(subtitle.snp.bottom).offset(24)
            make.leading.trailing.equalTo(subtitle)
            make.height.equalTo(44)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subtitle.snp.top).offset(-16)
            make.leading.trailing.equalTo(subtitle)
        }
        
        refreshButton.addTarget(self, action: #selector(refreshAction), for: .touchUpInside)
    }
}
