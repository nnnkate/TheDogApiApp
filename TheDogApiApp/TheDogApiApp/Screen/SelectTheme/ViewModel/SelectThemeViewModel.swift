//
//  SelectThemeViewModel.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import Foundation

protocol SelectThemeViewModelProtocol {
    func didSelectTheme(_ theme: ThemeName?, completion: @escaping () -> ())
}

final class SelectThemeViewModel {
    
    private let manager = SettingsManager.shared
    
}

// MARK: - SelectThemeViewModelProtocol
extension SelectThemeViewModel: SelectThemeViewModelProtocol {
    
    func didSelectTheme(_ theme: ThemeName?, completion: @escaping () -> ()) {
        manager.set(currentThemeName: theme)
        completion()
    }
    
}
