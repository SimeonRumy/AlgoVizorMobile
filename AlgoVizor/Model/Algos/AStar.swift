//
//  AStar.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 22/01/2022.
//

import Foundation

class AStar: Algorithm {
    
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
        unvisitedNodes = grid.fetchAllNodes().sorted()
        let end = grid.getEndNode()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.0001, repeats: true) { [self] _ in
            unvisitedNodes = unvisitedNodes.sorted()
            for n in unvisitedNodes {
                print(n.gridIndex, n.distance)
            }
            let node = unvisitedNodes.removeFirst()
            let closestNode = node
            if !closestNode.isWall {
                print(closestNode.gridIndex)
                if closestNode.distance == Double.greatestFiniteMagnitude { stopTimer(updateViewOnCompletion) }
                closestNode.isVisited = true
                updateViewDuringRun()
                visitedNodesInOrder.append(closestNode)
                if closestNode.gridIndex == end.gridIndex { stopTimer(updateViewOnCompletion) }
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
        }
    }
    
}
