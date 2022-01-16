//
//  MainView.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit

class MainView: UIView {
    
    let grid = GridView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        addSubview(grid)
        grid.anchorHeigth(to: self, multiplier: 0.7)
        grid.anchor(top: self.topAnchor,
                    leading: self.leadingAnchor,
                    bottom: nil,
                    trailing: self.trailingAnchor,
                    padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        grid.backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
