//
//  EmptyStateView.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 30.01.2025.
//

import UIKit

class EmptyStateView: UIView {
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    init(message: String, frame: CGRect) {
        super.init(frame: frame)
        messageLabel.text = message
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(messageLabel)
        
        messageLabel.anchorWithCenter(centerX: centerXAnchor,
                                      centerY: centerYAnchor)
        messageLabel.anchor(top: nil,
                            left: leftAnchor,
                            bottom: nil,
                            right: rightAnchor,
                            padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20))
    }
}

