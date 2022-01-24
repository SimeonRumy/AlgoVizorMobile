//
//  AlgoProtocol.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 21/01/2022.
//

import Foundation

protocol Algorithm: AnyObject {
    var grid: Grid { get set }
    func run(updateViewDuringRun: @escaping (GridIndex)->(), updateViewOnCompletion:  @escaping ()->())
    var timer : Timer? { get set }
}

extension Algorithm {
    
    func stopTimer(_ updateViewOnCompletion: @escaping () -> ()) {
      timer?.invalidate()
      timer = nil
      updateViewOnCompletion()
    }
    
    func getUnvisitedNeighbors(of node: Node) -> [Node] {
        let col = node.gridIndex.column
        let row = node.gridIndex.row
        var neighbors = [Node]()
        if (col > 0) {
            neighbors.append(grid.fetchNode(index: GridIndex(row: row, column: col - 1)))
        }
        if (row < grid.numberOfRows - 1) {
            neighbors.append(grid.fetchNode(index: GridIndex(row: row + 1, column: col)))
        }
        if (col < grid.numberOfCols - 1) {
            neighbors.append(grid.fetchNode(index: GridIndex(row: row, column: col + 1)))
        }
        if (row > 0) {
            neighbors.append(grid.fetchNode(index: GridIndex(row: row - 1, column: col)))
        }

        return neighbors.filter { !$0.isVisited }
        
    }
    
}
