//
//  MainView.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit

class MainView: UIView {
    
    let grid = GridView()
    let panel = ButtonPanel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        setupUI()
    }
    
    func setupUI() {
        addGrid()
        addPanel()
    }
    
    func addGrid() {
        addSubview(grid)
        addSubview(panel)
        grid.anchorHeigth(to: self, multiplier: 0.75)
        grid.anchor(top: self.topAnchor,
                    leading: self.leadingAnchor,
                    bottom: self.panel.topAnchor,
                    trailing: self.trailingAnchor,
                    padding: UIEdgeInsets(top: 00, left: 0, bottom: 0, right: 0))
    }
    
    func addPanel() {
        panel.anchor(top: grid.bottomAnchor,
                     leading: self.leadingAnchor,
                     bottom: self.bottomAnchor,
                     trailing: self.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
