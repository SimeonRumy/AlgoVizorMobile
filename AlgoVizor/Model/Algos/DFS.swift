//
//  DFS.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 23/01/2022.
//

import Foundation

class DFS: Algorithm {
    
    var grid: Grid
    var visitedNodesInOrder = [Node]()
    var unvisitedNodes = [Node]()
    
    init(grid: Grid) {
        self.grid = grid
    }
    
    var timer : Timer?
    
    func run(updateViewDuringRun: @escaping () -> (),  updateViewOnCompletion: @escaping () -> ()) {
        let start = grid.getStartNode()
        start.distance = 0
        unvisitedNodes = [start]
        let end = grid.getEndNode()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.0001, repeats: true) { [self] _ in
            let node = unvisitedNodes.removeFirst()
            let closestNode = node
            if !closestNode.isWall {
                closestNode.isVisited = true
                updateViewDuringRun()
                visitedNodesInOrder.append(closestNode)
                if closestNode.gridIndex == end.gridIndex { stopTimer(updateViewOnCompletion) }
                unvisitedNodes = getUnvisitedNeighbors(of: node) + unvisitedNodes
                print(unvisitedNodes.count)
            }
            
        }
        
    }
    
}
