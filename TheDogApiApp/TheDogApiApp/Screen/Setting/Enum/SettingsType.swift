//
//  SettingsType.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

enum SettingsType: CaseIterable {
    case theme
}

extension SettingsType {
    
    var title: String {
        switch self {
        case .theme:
            return "theme_title".localized
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .theme:
            return UIImage(systemName: "paintbrush.pointed.fill")
        }
    }
    
}



