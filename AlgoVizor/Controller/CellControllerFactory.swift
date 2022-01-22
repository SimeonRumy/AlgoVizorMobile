//
//  CellControllerFactory.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 19/01/2022.
//

import UIKit

class CellControllerFactory {
    
    func registerCells(on collectionView: UICollectionView) {
        WallNodeCellController.registerCell(on: collectionView)
        EndNodeCellController.registerCell(on: collectionView)
        StartNodeCellController.registerCell(on: collectionView)
        NodeCellController.registerCell(on: collectionView)
    }
    
    func cellControllers(with items: [Node]) -> [CollectionCellController] {
        return items.map { item in
            
            if item.isEnd {
                return EndNodeCellController(item: item)
            } else if item.isStart {
                return StartNodeCellController(item: item)
            } else if item.isWall {
                return WallNodeCellController(item: item)
            } else {
                return NodeCellController(item: item)
            }
        }
    }
    
}
