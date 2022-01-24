//
//  EndGrid.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit

class EndNodeCell: NodeCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.84, green: 0.19, blue: 0.19, alpha: 1.00)
        layer.borderColor = UIColor(red: 0.84, green: 0.19, blue: 0.19, alpha: 1.00).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
