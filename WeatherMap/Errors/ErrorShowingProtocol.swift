//
//  ErrorShowingProtocol.swift
//  WeatherMap
//
//  Created by SalemMacPro on 19.5.21.
//

import UIKit

protocol ErrorShowingProtocol {
    func showError(_ error: ResponseError, completion: @escaping () -> Void)
}

extension ErrorShowingProtocol where Self: UIViewController {
  func showError(_ error: ResponseError, completion: @escaping () -> Void) {
    let errorView = ErrorView(responseError:error, frame: view.frame)
    errorView.refresh = { [weak errorView] in
      errorView?.removeFromSuperview()
      completion()
    }
    view.addSubview(errorView)
  }
}
