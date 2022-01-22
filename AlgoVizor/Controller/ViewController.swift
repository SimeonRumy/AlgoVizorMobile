//
//  ViewController.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var grid: Grid? {
        didSet {
            setupButtons()
        }
    }
    
    fileprivate var cellControllers = [CollectionCellController]()
    fileprivate let cellControllerFactory = CellControllerFactory()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupCellControllers()
    }
    
    func setupDelegates() {
        guard let mainView = view as? MainView else { return }
        mainView.grid.grid.dataSource = self
        mainView.grid.grid.delegate = self
    }
    
    func setupCellControllers() {
        guard let mainView = view as? MainView else { return }
        cellControllerFactory.registerCells(on: mainView.grid.grid)
    }
    
    func setupButtons() {
        guard let mainView = view as? MainView else { return }
        var algor = Dijkstra(grid: grid!)
        mainView.panel.lauchButton.addAction(UIAction(handler: { [unowned self] action in
            algor.run(updateView: {
                cellControllers = self.cellControllerFactory.cellControllers(with: (grid?.fetchAllNodes())!)
                DispatchQueue.main.async {
                    mainView.grid.grid.reloadData()
                    mainView.grid.grid.collectionViewLayout.invalidateLayout()
                    mainView.grid.grid.layoutSubviews()
                }
            })
        }), for: .touchUpInside)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var toReload = grid?.userTappedOnNode(index: indexPath) ?? []
        print(toReload)
        cellControllers = cellControllerFactory.cellControllers(with: (grid?.fetchAllNodes())!)
        collectionView.reloadData()
//        toReload.append(indexPath)
//        print(toReload)
//        collectionView.reloadItems(at: [toReload[0]])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let height = collectionView.superview!.frame.height
        let width = collectionView.superview!.frame.width
        let contentDimensions = GridDimensionCalculator(viewHeight: Int(height), viewWidth: Int(width))
        return UIEdgeInsets(top: (height - CGFloat(contentDimensions.rowNumber*GRID_SIZE))/2,
                            left: (width - CGFloat(contentDimensions.colNumber*GRID_SIZE))/2,
                            bottom: (height - CGFloat(contentDimensions.rowNumber*GRID_SIZE))/2,
                            right: (width - CGFloat(contentDimensions.colNumber*GRID_SIZE))/2)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let calc = GridDimensionCalculator(viewHeight: Int(collectionView.superview!.frame.height),viewWidth: Int(collectionView.superview!.frame.width))
        if (grid == nil) { grid = Grid(numberOfCols: calc.colNumber, numberOfRows: calc.rowNumber) }
        if cellControllers.isEmpty { cellControllers = cellControllerFactory.cellControllers(with: (grid?.fetchAllNodes())!)}
        return calc.numberOfSquares
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellControllers[indexPath.row].cellFromCollectionView(collectionView, forIndexPath: indexPath)
    }
    
}


struct Grid {
    
    private var data: [[Node]] = []
    private var elementSelectionState: ElementState = .Start
    
    private var currentStart: GridIndex
    private var currentEnd: GridIndex
    
    var numberOfRows: Int
    var numberOfCols: Int
    
    init(numberOfCols: Int, numberOfRows: Int) {
        self.numberOfRows = numberOfRows
        self.numberOfCols = numberOfCols
        currentStart = GridIndex(row: 2, column: 2)
        currentEnd = GridIndex(row: numberOfRows - 2, column: numberOfCols - 2)
        initGrid(numberOfRows, numberOfCols)
        
    }
    
    func getStartNode() -> Node {
        return data[currentStart.row][currentStart.column]
    }
    
    func getEndNode() -> Node {
        return data[currentEnd.row][currentEnd.column]
    }
    
    mutating func fetchAllNodes() -> [Node] {
        return data.flatMap { $0 }
    }
    
    mutating func fetchNode(index: GridIndex) -> Node {
        return data[index.row][index.column]
    }
    
    mutating func userTappedOnNode(index: IndexPath) -> [IndexPath] {
        let index = getGridIndex(index: index)
        var toReload = [IndexPath]()
        print(index)
        switch elementSelectionState {
        case .Wall:
            let currentState = data[index.row][index.column].isWall
            data[index.row][index.column].isWall = !currentState
        case .Start:
            data[index.row][index.column].isStart = true
            toReload.append(getIndexPath(index: currentStart))
            data[currentStart.row][currentStart.column].isStart = false
            currentStart = index
        case .End:
            data[index.row][index.column].isEnd = true
            toReload.append(getIndexPath(index: currentEnd))
            data[currentEnd.row][currentEnd.column].isEnd = false
            currentEnd = index
        }
        print(currentStart)
        return toReload
    }
    
    mutating func elementSelectionStateChanged(state: ElementState) {
        elementSelectionState = state
    }
    
    mutating func resetAllNodes() {
        initGrid(numberOfRows, numberOfCols)
    }
    
    private mutating func setDefaultStartEndNodes(_ numberOfRows: Int, _ numberOfCols: Int) {
        currentStart = GridIndex(row: 2, column: 2)
        currentEnd = GridIndex(row: numberOfRows - 3, column: numberOfCols - 3)
    }
    
    private mutating func initGrid(_ numberOfRows: Int, _ numberOfCols: Int) {
        for row in 0..<numberOfRows {
            data.append(Array.init(repeating: Node(gridIndex: GridIndex(row: 1, column: 1)), count: numberOfCols))
            for col in 0..<numberOfCols {
                let index = GridIndex(row: row, column: col)
                let node = Node(gridIndex: index)
                node.isStart = index == currentStart
                node.isEnd = index == currentEnd
                data[row][col] = node
            }
        }
    }
    
    private func getGridIndex(index: IndexPath) -> GridIndex {
        let row = index.row / numberOfCols
        let col = index.row % numberOfCols
        return GridIndex(row: row, column: col)
    }
    
    private func getIndexPath(index: GridIndex) -> IndexPath {
        return IndexPath(row: index.row * index.column, section: 0)
    }
    
    
}


enum ElementState {
    case Wall
    case Start
    case End
}

