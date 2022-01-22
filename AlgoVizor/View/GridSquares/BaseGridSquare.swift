//
//  BaseGridSquare.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit

class NodeCell: UICollectionViewCell {
    
    var isVisited = false {
        didSet {
            if isVisited {
                backgroundColor = .yellow
            } else {
                backgroundColor = .lynxWhite
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
