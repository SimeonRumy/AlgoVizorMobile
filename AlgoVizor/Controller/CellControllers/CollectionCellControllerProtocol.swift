//
//  CollectionCellControllerProtocol.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 19/01/2022.
//

import UIKit

protocol CollectionCellController {
    static func registerCell(on collectionView: UICollectionView)
    func cellFromCollectionView(_ collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> UICollectionViewCell
    func cellWasVisited()
}
