//
//  AlgoProtocol.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 21/01/2022.
//

import Foundation

protocol AlgoritmDelegate: AnyObject {
    func nodeVisited(index: GridIndex)
    func algorithmFinishedRunning()
    func nodeIsShortestsPath(index: GridIndex)
}

protocol Algorithm: AnyObject {
    var grid: Grid { get set }
    var mainAlgoTimer : Timer? { get set }
    var shortestPathMarkerTimer : Timer? { get set }
    var delegate: AlgoritmDelegate? { get set }
    func run()
    func markShortestPathNodes(endNode: Node)
    func stopExecution(endNode: Node)
    
}

extension Algorithm {
    
    func stopExecution(endNode: Node) {
        stopTimer()
        markShortestPathNodes(endNode: endNode)
        delegate?.algorithmFinishedRunning()
    }
    
    func stopTimer() {
        mainAlgoTimer?.invalidate()
        mainAlgoTimer = nil
    }
    
    func markShortestPathNodes(endNode: Node) {
        var currentNode: Node = endNode
        var nodesInShortestPathOrder = [Node]()
        while currentNode.prevNode != nil {
            currentNode = currentNode.prevNode!
            nodesInShortestPathOrder.append(currentNode)
        }
        shortestPathMarkerTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [self] _ in
            if nodesInShortestPathOrder.isEmpty {
                shortestPathMarkerTimer?.invalidate()
                shortestPathMarkerTimer = nil
                return
            }
            currentNode = nodesInShortestPathOrder.removeLast()
            currentNode.isShortestPathNode = true
            delegate?.nodeIsShortestsPath(index: currentNode.gridIndex)
        }
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
