//
//  BaseCollectionViewDataSource.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

class BaseCollectionViewDataSource<Delegate: AnyObject, Model: BaseCollectionViewCellItem>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private(set) unowned var collectionView: UICollectionView
    
    // - Delegate
    private(set) weak var delegate: Delegate?
    private(set) weak var scrollViewDelegate: ScrollViewDelegate?
    
    // - Data
    private(set) var items: [Model] = []
    
    // - Init
    init(collectionView: UICollectionView,
         delegate: Delegate?,
         scrollViewDelegate: ScrollViewDelegate? = nil) {
        self.collectionView = collectionView
        self.delegate = delegate
        self.scrollViewDelegate = scrollViewDelegate
        super.init()
        configure()
    }
    
    // - Configure
    func configure() {
        registerCells()
        configureCollectionViewLayout()
        setupDataSource()
        collectionView.updateDataSource(dataSource: self)
    }
    
    func configureCollectionViewLayout() {
        let layout = SnappingCollectionViewLayout()
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .horizontal
        layout.invalidateLayout()
        collectionView.collectionViewLayout = layout
    }
    
    func setupDataSource() {
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
    }
    
    // - Register
    func registerCells() {
        fatalError("Require implementation")
    }
    
    // - Update
    func reloadData(items: [Model] = []) {
        self.items = items
        self.collectionView.reloadData()
    }
    
    func updateData(items: [Model]) {
        self.items = items
    }
    
    // - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Require implementation")
    }
    
    // - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        fatalError("Require implementation")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    // - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = .init(scaleX: 0.92, y: 0.92)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, animations: {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = .identity
            }
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll(scrollView)
    }
    
}

// MARK: - BaseProtocol
protocol BaseCollectionViewDelegate: AnyObject {
    
}

// MARK: - BaseCollectionViewCellItem
class BaseCollectionViewCellItem {
    
}

// MARK: - UICollectionView
extension UICollectionView {
    
    func updateDataSource<Delegate, Model: BaseCollectionViewCellItem>(dataSource: BaseCollectionViewDataSource<Delegate, Model>?) {
        self.delegate = dataSource
        self.dataSource = dataSource
    }
    
}
