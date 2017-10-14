//
//  ListLayout.swift
//  GridLayout
//
//  Created by ORLANDO RIVERA on 10/14/17.
//  Copyright © 2017 DigitalSummit. All rights reserved.
//
import UIKit

class ListLayout: UICollectionViewFlowLayout {

    var itemHeight: CGFloat = 180

    init(itemHeight: CGFloat) {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1

        self.itemHeight = itemHeight
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                let itemWidth: CGFloat = collectionView.frame.width
                return CGSize(width: itemWidth, height: self.itemHeight)
            }

            // Default fallback
            return CGSize(width: 100, height: 100)
        }
        set {
            super.itemSize = newValue
        }
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return proposedContentOffset
    }
    
}
