//
//  StoreFrontCollectionViewLayout.swift
//  BoostApp
//
//  Created by Ondrej Rafaj on 16/04/2018.
//  Copyright © 2018 LiveUI. All rights reserved.
//

import Foundation
import UIKit


class StoreFrontCollectionViewLayout: UICollectionViewLayout {
    
    var screenSize: CGSize {
        didSet {
            invalidateLayout()
        }
    }
    
    private var numberOfColumns: Int = 1
    private var cellMargin: CGFloat = 6
    
    private var cellCache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var headerCache: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: Initialization
    
    override init() {
        screenSize = UIScreen.main.bounds.size
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    override func invalidateLayout() {
        cellCache.removeAll()
        headerCache.removeAll()
        
        super.invalidateLayout()
    }
    
    override func prepare() {
        // 1. Only calculate once
        guard cellCache.isEmpty == true, let collectionView = collectionView else {
            return
        }
        
        numberOfColumns = Int(floor(screenSize.width / device.minCellWidth))
        
        // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // 3. Iterates through the list of items in the first section
        for section in 0 ..< collectionView.numberOfSections {
            // Create header attribute
            let headerIndexPath = IndexPath(item: 0, section: section)
            let height: CGFloat = 54
            let headerAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, with: headerIndexPath)
            headerAttribute.frame = CGRect(x: 0, y: (yOffset.max() ?? 0), width: (columnWidth * CGFloat(numberOfColumns)), height: height)
            headerCache[headerIndexPath] = headerAttribute
            
            // Calculate new Y for the next header
            yOffset = [CGFloat](repeating: (yOffset.max() ?? 0) + height, count: numberOfColumns)
            
            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                
                // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
                let cellHeight: CGFloat = 54
                let height = cellMargin * 2 + cellHeight
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellMargin, dy: cellMargin)
                
                // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                cellCache[indexPath] = attributes
                
                // 6. Updates the collection view content height
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = (column < (numberOfColumns - 1)) ? (column + 1) : 0
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the header cache and look for items in the rect
        for attributes in headerCache.values {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        // Loop through the cell cache and look for items in the rect
        for attributes in cellCache.values {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellCache[indexPath]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return headerCache[indexPath]
    }
    
}
