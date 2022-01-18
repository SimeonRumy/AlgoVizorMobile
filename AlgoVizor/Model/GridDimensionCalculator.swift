//
//  GridDimensionCalculator.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 18/01/2022.
//

import UIKit

struct GridDimensionCalculator {
    
    private let minSize = GRID_SIZE
    
    let viewHeight: Int
    let viewWidth: Int
    
    var rowNumber: Int {
        return viewHeight / minSize
    }
    
    var colNumber: Int {
        return viewWidth / minSize
    }
    
    var numberOfSquares: Int {
        return colNumber * rowNumber
    }
    
    func getGridIndex(index: IndexPath) -> GridIndex {
        let row = index.item / rowNumber
        let col = index.item % rowNumber
        return GridIndex(row: row, column: col)
    }
}
