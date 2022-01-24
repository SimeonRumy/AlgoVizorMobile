//
//  AlgoFactory.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 24/01/2022.
//

import UIKit

enum Algorithms: String, CaseIterable, RawRepresentable {
    case Dijkstra
    case Astar
    case BFS
    case DFS
}

class AlgorithmFactory {
    
    var selectedAlgorithm: Algorithms = .Dijkstra
         
    init() {
        
    }
    
    func getAlgorithm(grid: Grid) -> Algorithm {
        switch selectedAlgorithm {
        case .Dijkstra:
            return Dijkstra(grid: grid)
        case .Astar:
            return AStar(grid: grid)
        case .BFS:
            return Dijkstra(grid: grid)
        case .DFS:
            return DFS(grid: grid)
        }
    }

    
    func getAlgorithmActions() -> [UIAction] {
        var actions = [UIAction]()
        for algorithm in Algorithms.allCases {
            actions.append(UIAction(title: algorithm.rawValue) { [unowned self] action in
                selectedAlgorithm = algorithm
            })
        }
        return actions
    }
    
    
}
