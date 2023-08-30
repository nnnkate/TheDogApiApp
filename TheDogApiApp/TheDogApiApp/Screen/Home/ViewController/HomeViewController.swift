//
//  ViewController.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    // - UI
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    // - ViewModel
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel()
    
    // - DataSource
    private var dataSource: HomeDataSource?

    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataSourceData(items: viewModel.items, isResultLoaded: viewModel.isResultLoaded)
        updateUI()
    }
    
    // BaseViewController
    override func updateUI() {
        view.backgroundColor = Theme.shared.getColor(color: .background)
    }
        
}

// MARK: - BreedDelegate
extension HomeViewController: BreedDelegate {
    
    func didSelectModel(_ model: BreedModel?) {
        let vc = WikiViewController()
        vc.set(url: model?.link)
        present(vc, animated: true)
    }
    
    func loadNextPage() {
        viewModel.loadNextPage { [weak self] items, isResultLoaded in
            self?.reloadDataSourceData(items: items, isResultLoaded: isResultLoaded)
        }
    }
    
}

// MARK: - DataSource
extension HomeViewController {
    
    func configureDataSource() {
        dataSource = HomeDataSource(collectionView: collectionView, delegate: self)
        dataSource?.breedDelegate = self
        reconfigureDataSource()
        reloadDataSourceData()
    }
    
    func reloadDataSourceData(items: [BreedModel] = [], isResultLoaded: Bool = false) {
        dataSource?.reloadData(items: items, isResultLoaded: isResultLoaded)
    }
    
    func reconfigureDataSource() {
        collectionView.updateDataSource(dataSource: dataSource)
    }
    
}

// MARK: - Configure
private extension HomeViewController {
    
    func configure() {
        updateUI()
        addSubviews()
        makeConstraints()
        subscribe()
        configureDataSource()
        viewModel.loadPage { [weak self] items, isResultLoaded in
            self?.reloadDataSourceData(items: items, isResultLoaded: isResultLoaded)
        }
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.bottom.equalTo(-10)
        }
    }
        
}

