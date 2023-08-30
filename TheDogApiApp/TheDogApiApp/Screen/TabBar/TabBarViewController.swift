//
//  TabBarViewController.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit
import SnapKit

final class TabBarViewController: UITabBarController {
    
    // - Item
    private var homeTabBarItem: UITabBarItem? = nil
    private var settingsTabBarItem: UITabBarItem? = nil
    
    // - ViewController
    private var homeVC: HomeViewController? = nil
    private var settingsVC: SettingsViewController? = nil
    
    // - UI
    private lazy var bgImageView = {
        let imageView = UIImageView(image: UIImage(named: "bottom_gradient"))
        return imageView
    }()
    private lazy var backgroundView = {
        let view = UIView()
        view.layer.cornerRadius = PhoneSize.type == .small ? 38 : 44
        view.addShadow(radius: 15)
        return view
    }()
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        Theme.shared.unsubscribe(subscriber: self)
    }
    
}

// MARK: - ViewController
private extension TabBarViewController {
    
    func buildHomeVC() -> UIViewController {
        homeVC = HomeViewController()
        return homeVC ?? UIViewController()
    }
    
    func buildSettingsVC() -> UIViewController {
        settingsVC = SettingsViewController()
        return settingsVC ?? UIViewController()
    }
    
}

// MARK: - Update
private extension TabBarViewController {
    
    func updateUI() {
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: Theme.shared.getColor(color: .tabbarNormal)],
                                                         for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: Theme.shared.getColor(color: .tabbarSelected)],
                                                         for: .selected)
        
        UITabBar.appearance().unselectedItemTintColor = Theme.shared.getColor(color: .tabbarNormal)
        
        homeTabBarItem = UITabBarItem()
        homeTabBarItem?.image = UIImage(named: "home_icon")
        homeTabBarItem?.imageInsets = UIEdgeInsets(top: PhoneSize.type == .small ? -25 : -5, left: -5, bottom: -5, right: -5)
        
        if let homeTabBarItem {
            homeVC?.tabBarItem = homeTabBarItem
        }
            
        settingsTabBarItem = UITabBarItem()
        settingsTabBarItem?.image = UIImage(named: "settings_icon")
        settingsTabBarItem?.imageInsets = UIEdgeInsets(top: PhoneSize.type == .small ? -23 : -3, left: -3, bottom: -3, right: -3)
        
        if let settingsTabBarItem {
            settingsVC?.tabBarItem = settingsTabBarItem
        }
        
        backgroundView.backgroundColor = Theme.shared.getColor(color: .tabbarBg)
        tabBar.tintColor = Theme.shared.getColor(color: .tabbarSelected)
        bgImageView.tintColor = Theme.shared.getColor(color: .background)
    }
    
}

// MARK: - ThemeSubscriber
extension TabBarViewController: ThemeSubscriber {
    
    func themeDidChange() {
        updateUI()
    }
    
}

// MARK: - Configure
extension TabBarViewController {
    
    func configure() {
        configureTabBar()
        subscribe()
        addSubviews()
        makeConstraints()
    }
    
    func configureTabBar() {
        tabBar.barTintColor = .clear
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        viewControllers = [buildHomeVC(),
                           buildSettingsVC()]
        selectedIndex = 0
    }
    
    func addSubviews() {
        tabBar.addSubview(bgImageView)
        tabBar.addSubview(backgroundView)
    }
    
    func makeConstraints() {
        bgImageView.snp.makeConstraints {
            $0.height.equalTo(PhoneSize.type == .small ? 110 : 150)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(PhoneSize.type == .small ? 80 : 100)
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.bottom.equalTo(PhoneSize.type == .small ? -5 : -20)
            $0.centerX.equalToSuperview()
        }
        
       
    }
    
    func subscribe() {
        Theme.shared.subscribe(subscriber: self)
    }
    
    
}

