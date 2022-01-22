//
//  WallCellController.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 19/01/2022.
//

import UIKit

class WallNodeCellController: CollectionCellController {
    
    fileprivate let item: Node
    
    init(item: Node) {
        self.item = item
    }
    
    fileprivate static var cellIdentifier: String {
        return String(describing: type(of: WallNodeCell.self))
    }
    
    
    static func registerCell(on collectionView: UICollectionView) {
        collectionView.register(WallNodeCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func cellFromCollectionView(_ collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath) as! WallNodeCell
        
        // Configure photo cell...
        
        return cell
    }
    
    
    func cellWasVisited() {
        // Do something for photo...
    }
    
}
