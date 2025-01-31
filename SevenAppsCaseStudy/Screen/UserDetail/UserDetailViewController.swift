//
//  UserDetailViewController.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 29.01.2025.
//

import UIKit

final class UserDetailViewController: UIViewController {
    private let user: User
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 6
        view.layer.shadowOpacity = 0.1
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        return stackView
    }()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(detailsStackView)
        
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
        
        containerView.anchor(top: scrollView.topAnchor,
                           left: scrollView.leftAnchor,
                           bottom: scrollView.bottomAnchor,
                           right: scrollView.rightAnchor,
                           padding: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16))
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        
        nameLabel.anchor(top: containerView.topAnchor,
                        left: containerView.leftAnchor,
                         bottom: nil,
                        right: containerView.rightAnchor,
                        padding: UIEdgeInsets(top: 24, left: 16, bottom: 0, right: -16))
        
        detailsStackView.anchor(top: nameLabel.bottomAnchor,
                              left: containerView.leftAnchor,
                              bottom: containerView.bottomAnchor,
                              right: containerView.rightAnchor,
                              padding: UIEdgeInsets(top: 24, left: 16, bottom: -24, right: -16))
    }
    
    private func configureUI() {
        title = "User Details"
        
        nameLabel.text = user.name
        
        // Add info sections
        addInfoSection(title: "Contact", items: [
            ("Email:", user.email),
            ("Phone:", user.phone),
            ("Website:", user.website)
        ])
        
        addInfoSection(title: "Address", items: [
            ("Street:", user.address.street),
            ("Suite:", user.address.suite),
            ("City:", user.address.city),
            ("Zipcode:", user.address.zipcode)
        ])
        
        addInfoSection(title: "Company", items: [
            ("Name:", user.company.name),
            ("Catch Phrase:", user.company.catchPhrase),
            ("BS:", user.company.bs)
        ])
    }
    
    private func addInfoSection(title: String, items: [(String, String)]) {
        let sectionView = createSectionView(title: title)
        let itemsStack = createItemsStack(items: items)
        
        sectionView.addArrangedSubview(itemsStack)
        detailsStackView.addArrangedSubview(sectionView)
    }
    
    private func createSectionView(title: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.text = title
        titleLabel.textColor = .systemBlue
        
        let separator = UIView()
        separator.backgroundColor = UIColor.systemGray5
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(separator)
        
        return stackView
    }
    
    private func createItemsStack(items: [(String, String)]) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        
        for (key, value) in items {
            let itemView = UIStackView()
            itemView.axis = .horizontal
            itemView.spacing = 6
            
            let keyLabel = UILabel()
            keyLabel.font = .systemFont(ofSize: 15, weight: .medium)
            keyLabel.text = key
            keyLabel.textColor = .gray
            keyLabel.translatesAutoresizingMaskIntoConstraints = false
            keyLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
            
            let valueView = createValueView(isButton: key == "Website:", value: value)
           
            itemView.addArrangedSubview(keyLabel)
            itemView.addArrangedSubview(valueView)
            
            stackView.addArrangedSubview(itemView)
        }
        
        return stackView
    }
    
    private func createValueView(isButton: Bool, value: String) -> UIView {
        if isButton {
            let valueButton = UIButton()
            valueButton.backgroundColor = .clear
            valueButton.setTitle(value, for: .normal)
            valueButton.setTitleColor(.systemBlue, for: .normal)
            valueButton.titleLabel?.font = .systemFont(ofSize: 15)
            valueButton.contentHorizontalAlignment = .left
            valueButton.addTarget(self, action: #selector(websiteButtonTapped(_:)), for: .touchUpInside)
            
            return valueButton
        } else {
            let valueLabel = UILabel()
            valueLabel.font = .systemFont(ofSize: 15)
            valueLabel.text = value
            valueLabel.numberOfLines = 0
            
            return valueLabel
        }
    }
    
    // MARK: - Actions
    @objc private func websiteButtonTapped(_ sender: UIButton) {
        if let websiteText = sender.titleLabel?.text,
           let url = URL(string: "https://\(websiteText)") {
            UIApplication.shared.open(url)
        }
    }
}
