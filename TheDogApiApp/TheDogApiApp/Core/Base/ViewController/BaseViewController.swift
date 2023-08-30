//
//  BaseViewController.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

class BaseViewController: UIViewController {
    
    deinit {
        Theme.shared.unsubscribe(subscriber: self)
    }
    
    func subscribe() {
        Theme.shared.subscribe(subscriber: self)
        updateUI()
    }
    
    func updateUI() {

    }
    
}

// MARK: - ThemeSubscriber
extension BaseViewController: ThemeSubscriber {
    
    func themeDidChange() {
        updateUI()
    }
    
}
