//
//  Dijkstra.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 21/01/2022.
//

import Foundation

class Dijkstra: Algorithm {
    
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
        unvisitedNodes = grid.fetchAllNodes().sorted()
        let end = grid.getEndNode()
        
        mainAlgoTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [self] _ in
            unvisitedNodes = unvisitedNodes.sorted()
            let node = unvisitedNodes.removeFirst()
            let closestNode = node
            if !closestNode.isWall {
                if closestNode.distance == Double.greatestFiniteMagnitude { stopExecution(endNode: end) }
                closestNode.isVisited = true
                delegate?.nodeVisited(index: closestNode.gridIndex)
                visitedNodesInOrder.append(closestNode)
                if closestNode.gridIndex == end.gridIndex { stopExecution(endNode: end) }
                updateUnvisitedNeighbors(of: closestNode)
            }
            
        }
        
    }
    
    func updateUnvisitedNeighbors(of node: Node) {
        let unvisitedNeighbors = getUnvisitedNeighbors(of: node)
        for neighbor in unvisitedNeighbors {
            if ((node.distance + 1) < neighbor.distance ) {
                neighbor.distance = node.distance + 1
                neighbor.prevNode = node
            }
            
        }
    }
    
}
