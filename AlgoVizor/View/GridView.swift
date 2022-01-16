//
//  GridView.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//
import UIKit

let GRID_SIZE = 40

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

struct GridIndex {
    let row: Int
    let column: Int
}

protocol GridViewDelegate: AnyObject {
    func userSelectedGrid(gridIndex: GridIndex)
}

class GridView: UIView {
    
    private var grid: UICollectionView!
    weak var delegate: GridViewDelegate!
    private let reuseIdentifier = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = K.Colors.lynxWhite
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
        grid.backgroundColor = .red
        grid.dataSource = self
        grid.delegate = self
        grid.register(GridSquare.self, forCellWithReuseIdentifier: reuseIdentifier)
        grid.backgroundColor = .black
        grid.isScrollEnabled = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GridView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GridDimensionCalculator(viewHeight: Int(self.frame.height), viewWidth: Int(self.frame.width)).numberOfSquares
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GridSquare
        return cell
    }
    
}

extension GridView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let contentDimensions = GridDimensionCalculator(viewHeight: Int(self.frame.height), viewWidth: Int(self.frame.width))
        return UIEdgeInsets(top: (self.frame.height - CGFloat(contentDimensions.rowNumber*GRID_SIZE))/2,
                            left: (self.frame.width - CGFloat(contentDimensions.colNumber*GRID_SIZE))/2,
                            bottom: (self.frame.height - CGFloat(contentDimensions.rowNumber*GRID_SIZE))/2,
                            right: (self.frame.width - CGFloat(contentDimensions.colNumber*GRID_SIZE))/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let contentDimensions = GridDimensionCalculator(viewHeight: Int(self.frame.height), viewWidth: Int(self.frame.width))
        delegate.userSelectedGrid(gridIndex: contentDimensions.getGridIndex(index: indexPath))
    }
    
}

