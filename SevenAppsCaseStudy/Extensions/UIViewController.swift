//
//  UIViewController.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 30.01.2025.
//

import UIKit

extension UIViewController {
    private static var loadingViewTag = 99999
    
    func showLoading() {
        let loadingView = UIView(frame: view.bounds)
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        loadingView.tag = UIViewController.loadingViewTag
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
    }
    
    func hideLoading() {
        if let loadingView = view.viewWithTag(UIViewController.loadingViewTag) {
            loadingView.removeFromSuperview()
        }
    }
    
    func showAlert(title: String, message: String, buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

