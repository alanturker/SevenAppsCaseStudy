//
//  UserTableViewCell.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 29.01.2025.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    static let identifier = "UserTableViewCell"
    
    // MARK: - UI Elements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let websiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        // Create container view for shadow and rounded corners
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        contentView.addSubview(containerView)
        
        // Container view constraints with insets
        containerView.anchor(top: contentView.topAnchor,
                             left: contentView.leftAnchor,
                             bottom: contentView.bottomAnchor,
                             right: contentView.rightAnchor,
                             padding: UIEdgeInsets(top: 8, left: 16, bottom: -8, right: -16))
        
        // Add subviews to container
        [nameLabel, emailLabel, phoneLabel, websiteButton].forEach { containerView.addSubview($0) }
        
        // Setup constraints
        nameLabel.anchor(top: containerView.topAnchor,
                         left: containerView.leftAnchor,
                         bottom: nil,
                         right: containerView.rightAnchor,
                         padding: UIEdgeInsets(top: 12, left: 16, bottom: 0, right: -16))
        
        emailLabel.anchor(top: nameLabel.bottomAnchor,
                          left: containerView.leftAnchor,
                          bottom: nil,
                          right: containerView.rightAnchor,
                          padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: -16))
        
        phoneLabel.anchor(top: emailLabel.bottomAnchor,
                          left: containerView.leftAnchor,
                          bottom: nil,
                          right: containerView.rightAnchor,
                          padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: -16))
        
        websiteButton.anchor(top: phoneLabel.bottomAnchor,
                             left: containerView.leftAnchor,
                             bottom: containerView.bottomAnchor,
                             right: containerView.rightAnchor,
                             padding: UIEdgeInsets(top: 8, left: 16, bottom: -12, right: -16))
        
        websiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Configure
    func configure(with user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        websiteButton.setTitle(user.website, for: .normal)
    }
    
    // MARK: - Actions
    @objc private func websiteButtonTapped() {
        if let websiteText = websiteButton.title(for: .normal),
           let url = URL(string: "https://\(websiteText)") {
            UIApplication.shared.open(url)
        }
    }
}
