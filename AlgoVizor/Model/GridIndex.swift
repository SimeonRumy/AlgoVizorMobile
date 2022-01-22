//
//  GridIndex.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 18/01/2022.
//

import Foundation

extension GridIndex: Equatable {
    static func == (lhs: GridIndex, rhs: GridIndex) -> Bool {
        lhs.row == rhs.row && lhs.column == rhs.column
    }
    
}

struct GridIndex {
    let row: Int
    let column: Int
}
