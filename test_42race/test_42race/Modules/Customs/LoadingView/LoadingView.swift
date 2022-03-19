//
//  LoadingView.swift
//  test_42race
//
//  Created by For Test Only on 19/03/2022.
//

import UIKit

class LoadingView: UIView {

    // MARK: - Outlet
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            indicator.style = .whiteLarge
        }
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        configUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper Methods
extension LoadingView {
    private func configUI() {
        self.backgroundColor = .clear
        
        // Add background view
        self.addSubview(backgroundView)
        backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        // Add indicator view to content view
        self.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func startAnimate(superView: UIView) {
        self.frame = superView.frame
        superView.addSubview(self)
        self.indicator.startAnimating()
    }
    
    func stopAnimate() {
        self.indicator.stopAnimating()
        self.removeFromSuperview()
    }
}
