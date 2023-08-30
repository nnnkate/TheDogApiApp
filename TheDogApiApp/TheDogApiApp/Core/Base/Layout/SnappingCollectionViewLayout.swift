//
//  SnappingCollectionViewLayout.swift
//  TheDogApiApp
//
//  Created by Ekaterina Nedelko on 30.08.23.
//

import UIKit

final class SnappingCollectionViewLayout: UICollectionViewFlowLayout {
    
    private lazy var contentInset: CGFloat = collectionView?.contentInset.left ?? 0

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                      withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                             withScrollingVelocity: velocity)
        }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + contentInset

        let targetRect = CGRect(x: proposedContentOffset.x,
                                y: 0,
                                width: collectionView.bounds.size.width,
                                height: collectionView.bounds.size.height)

        let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

        layoutAttributesArray?.forEach { layoutAttributes in
            let itemOffset = layoutAttributes.frame.origin.x
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
    
}

// MARK: - Set
extension SnappingCollectionViewLayout {
    
    func set(contentInset: CGFloat) {
        self.contentInset = contentInset
    }
    
}
