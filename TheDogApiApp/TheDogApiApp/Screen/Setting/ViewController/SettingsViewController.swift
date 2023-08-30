//
//  SettingsViewController.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    // - UI
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    // - Data
    private(set) var items: [SettingModel] = SettingsType.allCases.map { SettingModel(type: $0) }
    
    // - DataSource
    private var dataSource: SettingsDataSource?

    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    // BaseViewController
    override func updateUI() {
        view.backgroundColor = Theme.shared.getColor(color: .background)
    }
    
}

// MARK: - SettingsDelegate
extension SettingsViewController: SettingsDelegate {
   
    func didSelectSetting(_ setting: SettingsType?) {
        let vc = SelectThemeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}

// MARK: - DataSource
private extension SettingsViewController {

    func configureDataSource() {
        dataSource = SettingsDataSource(tableView: tableView,
                                        delegate: self)
        dataSource?.settingsDelegate = self
        reconfigureDataSource()
        reloadDataSourceData()
    }

    func reloadDataSourceData() {
        dataSource?.reloadData(items: items)
    }

    func reconfigureDataSource() {
        tableView.updateDataSource(dataSource: dataSource)
    }
    
}

// MARK: - Configure
private extension SettingsViewController {
    
    func configure() {
        updateUI()
        addSubviews()
        makeConstraints()
        configureDataSource()
        subscribe()
    }
    
    func addSubviews() {
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
       tableView.snp.makeConstraints {
           $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
           $0.leading.equalTo(20)
           $0.trailing.equalTo(-20)
           $0.bottom.equalToSuperview()
       }
    }
    
}

