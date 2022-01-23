//
//  GridView.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//
import UIKit

let GRID_SIZE = 50


class GridView: UIView {
    
    var grid: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lynxWhite
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.estimatedItemSize = CGSize(width: GRID_SIZE, height: GRID_SIZE)
        grid = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        addSubview(grid)
        grid.fillSuperview()
        grid.backgroundColor = .black
        grid.isScrollEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
