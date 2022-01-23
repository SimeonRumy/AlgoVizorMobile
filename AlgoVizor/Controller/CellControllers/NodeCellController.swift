//
//  NodeCellController.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 19/01/2022.
//

import UIKit

class NodeCellController: CollectionCellController {
    
    fileprivate let item: Node
    
    init(item: Node) {
        self.item = item
    }
    
    fileprivate static var cellIdentifier: String {
        return String(describing: type(of: NodeCell.self))
    }
    
    
    static func registerCell(on collectionView: UICollectionView) {
        collectionView.register(NodeCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func cellFromCollectionView(_ collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: self).cellIdentifier, for: indexPath) as! NodeCell
        cell.isVisited = item.isVisited
//        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return cell
    }
    
    func cellWasVisited() {
    
    }
    
}

