//
//  Grid.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 22/01/2022.
//

import Foundation

class Grid {
    
    private var data: [[Node]] = []
    private var elementSelectionState: ElementState = .Start
    
    private var currentStart: GridIndex
    private var currentEnd: GridIndex
    
    var numberOfRows: Int
    var numberOfCols: Int
    
    init(numberOfCols: Int, numberOfRows: Int) {
        self.numberOfRows = numberOfRows
        self.numberOfCols = numberOfCols
        currentStart = GridIndex(row: 2, column: 2)
        currentEnd = GridIndex(row: numberOfRows - 2, column: numberOfCols - 2)
        initGrid(numberOfRows, numberOfCols)
        
    }
    
    func getStartNode() -> Node {
        return data[currentStart.row][currentStart.column]
    }
    
    func getEndNode() -> Node {
        return data[currentEnd.row][currentEnd.column]
    }
    
    func fetchAllNodes() -> [Node] {
        return data.flatMap { $0 }
    }
    
    func fetchNode(index: GridIndex) -> Node {
        return data[index.row][index.column]
    }
    
    func resetAllNodes() {
        for node in fetchAllNodes() {
            node.isVisited = false
            node.distance = Double.greatestFiniteMagnitude
        }
    }
    
   func userTappedOnNode(index: IndexPath) -> [IndexPath] {
        let index = getGridIndex(index: index)
        var toReload = [IndexPath]()
        print(index)
        switch elementSelectionState {
        case .Wall:
            let currentState = data[index.row][index.column].isWall
            data[index.row][index.column].isWall = !currentState
        case .Start:
            data[index.row][index.column].isStart = true
            toReload.append(getIndexPath(index: currentStart))
            data[currentStart.row][currentStart.column].isStart = false
            currentStart = index
        case .End:
            data[index.row][index.column].isEnd = true
            toReload.append(getIndexPath(index: currentEnd))
            data[currentEnd.row][currentEnd.column].isEnd = false
            currentEnd = index
        }
        print(currentStart)
        return toReload
    }
    
    func elementSelectionStateChanged(state: ElementState) {
        elementSelectionState = state
    }
    
    private func setDefaultStartEndNodes(_ numberOfRows: Int, _ numberOfCols: Int) {
        currentStart = GridIndex(row: 2, column: 2)
        currentEnd = GridIndex(row: numberOfRows - 3, column: numberOfCols - 3)
    }
    
    private func initGrid(_ numberOfRows: Int, _ numberOfCols: Int) {
        for row in 0..<numberOfRows {
            data.append(Array.init(repeating: Node(gridIndex: GridIndex(row: 1, column: 1)), count: numberOfCols))
            for col in 0..<numberOfCols {
                let index = GridIndex(row: row, column: col)
                let node = Node(gridIndex: index)
                node.isStart = index == currentStart
                node.isEnd = index == currentEnd
                data[row][col] = node
            }
        }
    }
    
    private func getGridIndex(index: IndexPath) -> GridIndex {
        let row = index.row / numberOfCols
        let col = index.row % numberOfCols
        return GridIndex(row: row, column: col)
    }
    
    private func getIndexPath(index: GridIndex) -> IndexPath {
        return IndexPath(row: (index.row + 1) * (index.column + 1), section: 0)
    }
    
    
}
