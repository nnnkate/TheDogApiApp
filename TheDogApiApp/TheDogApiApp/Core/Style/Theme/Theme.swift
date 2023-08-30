//
//  Theme.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

protocol AppTheme: AnyObject {
    func getColor(color: ColorName) -> UIColor
}

final class LightTheme: AppTheme {
    
    func getColor(color: ColorName) -> UIColor {
        switch (color) {
        case .tabbarNormal:
            return UIColor.light_purple
        case .tabbarSelected:
            return UIColor.light_darkPurple
        case .tabbarBg:
            return UIColor.light_pink
        case .background:
            return UIColor.light_lightPurple
        case .label:
            return UIColor.light_darkPurple
        case .separator:
            return UIColor.light_darkPurple
        case .view:
            return UIColor.light_pink
        case .tint:
            return UIColor.light_darkPurple
        default:
            return .red
//        case .title:
//            return accentBlue
//        case .subtitle:
//            return oceanLight
//        case .primary:
//            return primary
//        case .secondary:
//            return secondary
//        case .separator:
//            return white
//        case .label:
//            return oceanLight
//        case .view:
//            return white
//        case .shadow:
//            return shadow
        }
    }
    
}

final class DarkTheme: AppTheme {
    
    func getColor(color: ColorName) -> UIColor {
        switch (color) {
        case .tabbarNormal:
            return UIColor.dark_purple
        case .tabbarSelected:
            return UIColor.dark_biege
        case .tabbarBg:
            return UIColor.dark_darkPurple
        case .background:
            return UIColor.dark_lightPurple
        case .label:
            return UIColor.dark_biege
        case .separator:
            return UIColor.dark_biege
        case .view:
            return UIColor.dark_darkPurple
        case .tint:
            return UIColor.dark_biege
        default:
            return .red
            //        case .title:
            //            return accentBlue
            //        case .subtitle:
            //            return oceanLight
            //        case .primary:
            //            return primary
            //        case .secondary:
            //            return secondary
            //        case .separator:
            //            return white
            //        case .label:
            //            return oceanLight
            //        case .view:
            //            return white
            //        case .shadow:
            //            return shadow
            
        }
    }
    
}

protocol ThemeSubscriber: AnyObject {
    func themeDidChange()
}

final class Theme: AppTheme {
    
    static let shared = Theme()
    
    private(set) var theme: AppTheme = LightTheme() //DarkTheme()
    
    private var subscribers: [ThemeSubscriber] = []
    
    private init() {
        update()
    }
    
    func getColor(color: ColorName) -> UIColor {
        return theme.getColor(color: color)
    }
        
}

// MARK: - Update
extension Theme {
    
    func update() {
        switch UserDefaultsManager.shared.themeName {
        case ThemeName.light.rawValue:
            theme = LightTheme()
        case ThemeName.dark.rawValue:
            theme = DarkTheme()
        default:
            theme = UIScreen.main.traitCollection.userInterfaceStyle == .dark ? DarkTheme() : LightTheme()
        }
        notifySubscribers()
    }
    
}

// MARK: - Subscribers
extension Theme {
   
    func subscribe(subscriber: ThemeSubscriber) {
        subscribers.append(subscriber)
    }
    
    func unsubscribe(subscriber: ThemeSubscriber) {
        let index = subscribers.firstIndex { subs in
            subs === subscriber
        }
        guard let index = index else { return }
        subscribers.remove(at: index)
    }
    
    private func notifySubscribers() {
        subscribers.forEach { subscriber in
            subscriber.themeDidChange()
        }
    }
    
}
