//
//  HomeDataSource.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

protocol BreedDelegate: AnyObject {
    func didSelectModel(_ model: BreedModel?)
    func loadNextPage()
}

// MARK: - Update
extension HomeDataSource: BreedModelSubscriber {
   
    func notify(imageId: String?) {
        if let index = items.firstIndex(where: { ($0 as? BreedModel)?.imageId == imageId }) {
            if let cell = collectionView.cellForItem(at: IndexPath(row: index ?? 0, section: 0)) as? BreedCell, let model = items[index] as? BreedModel {
                cell.update()
            }
        }
    }
    
}

final class HomeDataSource: BaseCollectionViewDataSource<AnyObject, BaseCollectionViewCellItem> {
    
    // - Data
    private var isResultLoaded = false
    
    // - Delegate
    weak var breedDelegate: BreedDelegate?
    
    func reloadData(items: [BaseCollectionViewCellItem] = [], isResultLoaded: Bool) {
        items.forEach {
            if let item = $0 as? BreedModel {
                item.subscriber = self
            }
        }
        super.reloadData(items: items)
        self.isResultLoaded = isResultLoaded
    }
    
    override func setupDataSource() {
        collectionView.contentInset = .init(top: 30, left: 0, bottom: 100, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = false
    }
    
    override func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.invalidateLayout()
        collectionView.collectionViewLayout = layout
    }
        
    // - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return breedCell(cellForRowAt: indexPath)
    }
    
    // - UICollectionViewDelegateFlowLayout
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width, height: width)
    }
    
    // - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if let cell = cell as? BreedCell {
//            cell.update()
//        }
        if isResultLoaded {
            return
        }
        let count = items.count
        if count > 0, indexPath.row >= 8 {
            breedDelegate?.loadNextPage()
        }
    }
    
    // - Register
    override func registerCells() {
        collectionView.register(BreedCell.self, forCellWithReuseIdentifier: BreedCell.reuseID)
    }
    
}

// MARK: - Cell
private extension HomeDataSource {
    
    func breedCell(cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCell.reuseID, for: indexPath) as? BreedCell ?? BreedCell()
        cell.set(model: items[indexPath.row] as? BreedModel)
        cell.touchAction = { [weak self] model in
            self?.breedDelegate?.didSelectModel(model)
        }
        return cell
    }
    
}




