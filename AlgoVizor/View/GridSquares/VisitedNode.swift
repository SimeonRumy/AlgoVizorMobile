//
//  VisitedNode.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 24/01/2022.
//

import UIKit

class VisitedNode: NodeCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
