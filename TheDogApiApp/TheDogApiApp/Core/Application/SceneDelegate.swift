//
//  SceneDelegate.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = (scene as? UIWindowScene) else { return }
        setupWindow(window)
        setupNavigationController()
        setupAppTheme()
    }
    
}

// MARK: - Setup
private extension SceneDelegate {
    
    func setupWindow(_ window: UIWindowScene) {
        self.window = UIWindow(windowScene: window)
        self.window?.tintColor = .white
    }
    
    func setupNavigationController() {
        let navigationController = UINavigationController()
        let vc = TabBarViewController()
        navigationController.viewControllers = [vc]
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setNavigationBarHidden(true, animated: false)
        
        self.window!.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func setupAppTheme() {
        self.window?.overrideUserInterfaceStyle = .light
    }
    
}
