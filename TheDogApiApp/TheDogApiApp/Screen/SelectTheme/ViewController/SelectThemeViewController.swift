//
//  SelectThemeViewController.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

final class SelectThemeViewController: BaseViewController {
    
    // - UI
    private lazy var backButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .highlighted)
        button.addAnimatingPress()
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    // - Data
    private(set) var items = ThemeName.allCases.map { SelectThemeModel(name: $0) }
    
    // - DataSource
    private var dataSource: SelectThemeDataSource?

    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // - ViewModel
    private lazy var viewModel: SelectThemeViewModelProtocol = SelectThemeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    // BaseViewController
    override func updateUI() {
        view.backgroundColor = Theme.shared.getColor(color: .background)
        backButton.tintColor = Theme.shared.theme.getColor(color: .tint)
    }

}

// MARK: Action
private extension SelectThemeViewController {
    
    @objc func backButtonAction(_ sender: UIButton) {
       dismiss(animated: true)
    }
    
}

// MARK: - SelectThemeDelegate
extension SelectThemeViewController: SelectThemeDelegate {
    
    func didSelectTheme(_ theme: ThemeName?) {
        viewModel.didSelectTheme(theme) { [weak self] in
            self?.reloadDataSourceData()
        }
    }

}


// MARK: - DataSource
private extension SelectThemeViewController {

    func configureDataSource() {
        dataSource = SelectThemeDataSource(tableView: tableView,
                                        delegate: self)
        dataSource?.themeDelegate = self
        dataSource?.updateData(items: items)
        reconfigureDataSource()
        reloadDataSourceData()
    }

    func reloadDataSourceData() {
        dataSource?.reloadData()
    }

    func reconfigureDataSource() {
        tableView.updateDataSource(dataSource: dataSource)
    }
    
}

// MARK: - Configure
private extension SelectThemeViewController {
    
    func configure() {
        updateUI()
        addSubviews()
        makeConstraints()
        configureDataSource()
        subscribe()
    }
    
    func addSubviews() {
        view.addSubview(backButton)
        view.addSubview(tableView)
    }
    
    func makeConstraints() {
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(20)
            $0.height.width.equalTo(30)
        }
        
        tableView.snp.makeConstraints {
           $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
           $0.leading.equalTo(20)
           $0.trailing.equalTo(-20)
           $0.bottom.equalToSuperview()
       }
    }
    
}


