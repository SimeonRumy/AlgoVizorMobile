//
//  Dijkstra.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 21/01/2022.
//

import Foundation

class Dijkstra: Algorithm {
    
    var grid: Grid
    var visitedNodesInOrder = [Node]()
    var unvisitedNodes = [Node]()
    
    init(grid: Grid) {
        self.grid = grid
    }
    
    var timer : Timer?
    
    func run(updateView: @escaping () -> ()) {
        let start = grid.getStartNode()
        start.distance = 0
        unvisitedNodes = grid.fetchAllNodes().sorted()
        let end = grid.getEndNode()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [unowned self] _ in
            print("**")
            unvisitedNodes = unvisitedNodes.sorted()
//            for n in unvisitedNodes.elements {
//                print(n.gridIndex, n.distance)
//            }
            print("**")
            let node = unvisitedNodes.removeFirst()
            let closestNode = node
//            guard let closestNode = node else {
//                stopTimer()
//                return
//            }
            if !closestNode.isWall {
                print(closestNode.gridIndex)
                if closestNode.distance == Double.greatestFiniteMagnitude { stopTimer() }
                closestNode.isVisited = true
                updateView()
                visitedNodesInOrder.append(closestNode)
                if closestNode.gridIndex == end.gridIndex { stopTimer() }
                updateUnvisitedNeighbors(of: closestNode)
            }
            
        }
        
    }
    
    func stopTimer() {
      timer?.invalidate()
      timer = nil
    }
    
    func updateUnvisitedNeighbors(of node: Node) {
        let unvisitedNeighbors = getUnvisitedNeighbors(of: node)
        for neighbor in unvisitedNeighbors {
            // next conditional is very important
            // we are duplicating the nodes instead of changing priority
            // redudant neighbour nodes are created
            // already visted redundant nodes will have a distance smaller than the
            // total traveled distance plus length to new node
            // this prevents us from visting them again
            if ((node.distance + 1) < neighbor.distance ) {
                neighbor.distance = node.distance + 1
            }
            
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
