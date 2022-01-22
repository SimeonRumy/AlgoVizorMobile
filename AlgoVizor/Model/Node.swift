//
//  Node.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 20/01/2022.
//

import Foundation

class Node {
    
    init(gridIndex: GridIndex) {
        self.gridIndex = gridIndex
    }
    
    let gridIndex: GridIndex
    var isEnd: Bool = false
    var isStart: Bool = false
    var isWall: Bool = false
    var isVisited: Bool = false
    var distance: Double = Double.greatestFiniteMagnitude
     
}

extension Node: Comparable {
    
    static func < (lhs: Node, rhs: Node) -> Bool {
        lhs.distance < rhs.distance
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.distance == rhs.distance
    }
    
}
