//
//  UITableView.swift
//  SevenAppsCaseStudy
//
//  Created by Turker Alan on 30.01.2025.
//

import UIKit

extension UITableView {
    func showEmptyState(message: String) {
        let emptyView = EmptyStateView(message: message, frame: self.bounds)
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func hideEmptyState() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
