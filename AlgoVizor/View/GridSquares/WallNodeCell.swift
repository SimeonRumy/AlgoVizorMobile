//
//  WallGrid.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit

class WallNodeCell: NodeCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.17, green: 0.24, blue: 0.31, alpha: 1.00)
        layer.borderColor = UIColor(red: 0.17, green: 0.24, blue: 0.31, alpha: 1.00).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
