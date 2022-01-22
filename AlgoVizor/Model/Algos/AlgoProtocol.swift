//
//  AlgoProtocol.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 21/01/2022.
//

import Foundation

protocol Algorithm {
    var grid: Grid { get }
    mutating func run(updateView: @escaping ()->())
}
