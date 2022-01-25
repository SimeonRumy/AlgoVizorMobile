//
//  AStar.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 22/01/2022.
//

import Foundation

class AStar: Algorithm {
    var shortestPathMarkerTimer: Timer?
    
    
    var delegate: AlgoritmDelegate?
    
    
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
        
        mainAlgoTimer = Timer.scheduledTimer(withTimeInterval: 0.0001, repeats: true) { [self] _ in
            unvisitedNodes = unvisitedNodes.sorted()
            let node = unvisitedNodes.removeFirst()
            let closestNode = node
            if !closestNode.isWall {
                if closestNode.distance == Double.greatestFiniteMagnitude {stopExecution(endNode: end) }
                closestNode.isVisited = true
                delegate?.nodeVisited(index: closestNode.gridIndex)
                visitedNodesInOrder.append(closestNode)
                if closestNode.gridIndex == end.gridIndex { stopExecution(endNode: end) }
                updateUnvisitedNeighbors(of: closestNode)
            }
            
        }
        
    }
    
    func getEuclideanDistance(node: Node, finishNode: Node) -> Double {
        let e = pow(Double(node.gridIndex.row - finishNode.gridIndex.row), 2) + pow(Double(node.gridIndex.column - finishNode.gridIndex.column),2)
        return e.squareRoot()
    }
    
    func updateUnvisitedNeighbors(of node: Node) {
        let unvisitedNeighbors = getUnvisitedNeighbors(of: node)
        for neighbor in unvisitedNeighbors {
            neighbor.distance = node.distance + 1 -
            getEuclideanDistance(node: node, finishNode: grid.getEndNode()) +
            getEuclideanDistance(node: neighbor, finishNode: grid.getEndNode())
            neighbor.prevNode = node
        }
    }
    
}
