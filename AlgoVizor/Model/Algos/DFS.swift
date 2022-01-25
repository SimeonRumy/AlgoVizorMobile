//
//  DFS.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 23/01/2022.
//

import Foundation

class DFS: Algorithm {
    var shortestPathMarkerTimer: Timer?
    
    weak var delegate: AlgoritmDelegate?
    
    
    var grid: Grid
    var visitedNodesInOrder = [Node]()
    var unvisitedNodes = [Node]()
    
    init(grid: Grid) {
        self.grid = grid
    }
    
    var mainAlgoTimer : Timer?
    
    func run() {
        let start = grid.getStartNode()
        start.distance = 0
        unvisitedNodes = [start]
        let end = grid.getEndNode()
        
        mainAlgoTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [self] _ in
            let node = unvisitedNodes.removeFirst()
            let closestNode = node
            if !closestNode.isWall {
                closestNode.isVisited = true
                delegate?.nodeVisited(index: closestNode.gridIndex)
                visitedNodesInOrder.append(closestNode)
                if closestNode.gridIndex == end.gridIndex { stopExecution(endNode: end) }
                unvisitedNodes = getUnvisitedNeighbors(of: node) + unvisitedNodes
            }
            
        }
        
    }
    
}
