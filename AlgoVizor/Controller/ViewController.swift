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
    fileprivate let algorithmFactory = AlgorithmFactory()
    
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
        setupAlgorithms()
    }
    
    func setupDelegates() {
        guard let mainView = view as? MainView else { return }
        mainView.grid.grid.dataSource = self
        mainView.grid.grid.delegate = self
    }
    
    func setupAlgorithms() {
        guard let mainView = view as? MainView else { return }
        mainView.panel.algoSelectionButton.menu = UIMenu(title: "Menu", children: algorithmFactory.getAlgorithmActions())
    }
    
    func setupCellControllers() {
        guard let mainView = view as? MainView else { return }
        cellControllerFactory.registerCells(on: mainView.grid.grid)
    }
    
    func setupButtons() {
        
        guard let mainView = view as? MainView else { return }
        
        mainView.panel.lauchButton.addAction(UIAction(handler: { [unowned self] action in
            let algo =  algorithmFactory.getAlgorithm(grid: grid!)
            algo.delegate = self
            mainView.panel.isAlgoRunning = true
            grid?.resetAllNodes()
            mainView.grid.grid.reloadData()
            switchButtons()
            algo.run()
        }), for: .touchUpInside)
        
        var buttons = [mainView.panel.addWallButton, mainView.panel.setStartButton, mainView.panel.resetGridButton]
                       
        mainView.panel.addWallButton.addAction(UIAction(handler: { [unowned self] action in
            for button in buttons { button.isSelected = false }
            grid?.elementSelectionStateChanged(state: .Wall)
            mainView.panel.addWallButton.isSelected = true
        }), for: .touchUpInside)
        
        mainView.panel.setStartButton.addAction(UIAction(handler: { [unowned self] action in
            for button in buttons { button.isSelected = false }
            grid?.elementSelectionStateChanged(state: .Start)
            mainView.panel.setStartButton.isSelected = true
        }), for: .touchUpInside)
        
        mainView.panel.setEndButton.addAction(UIAction(handler: { [unowned self] action in
            for button in buttons { button.isSelected = false }
            grid?.elementSelectionStateChanged(state: .End)
            mainView.panel.setEndButton.isSelected = true
        }), for: .touchUpInside)
        
        mainView.panel.resetGridButton.addAction(UIAction(handler: { [unowned self] action in
            grid?.resetAllNodes()
            mainView.grid.grid.reloadData()
        }), for: .touchUpInside)
        
    }
    
    func switchButtons() {
        
        guard let mainView = view as? MainView else { return }
        
        mainView.panel.lauchButton.isEnabled = !mainView.panel.lauchButton.isEnabled
        mainView.panel.addWallButton.isEnabled = !mainView.panel.addWallButton.isEnabled
        mainView.panel.setEndButton.isEnabled = !mainView.panel.setEndButton.isEnabled
        mainView.panel.setStartButton.isEnabled = !mainView.panel.setStartButton.isEnabled
        mainView.panel.resetGridButton.isEnabled = !mainView.panel.resetGridButton.isEnabled
    }
    
}

//wh7ytmmty

extension ViewController: AlgoritmDelegate {
    
    func nodeVisited(index: GridIndex) {
        DispatchQueue.main.async { [self] in
            (cellControllers[grid!.getIndexPath(index: index).row] as? NodeCellController)?.cellReference?.isVisited = true
        }
    }
    
    func algorithmFinishedRunning() {
        guard let mainView = view as? MainView else { return }
        mainView.panel.isAlgoRunning = false
        mainView.panel.lauchButton.setNeedsUpdateConfiguration()
        switchButtons()
    }
    
    func nodeIsShortestsPath(index: GridIndex) {
        DispatchQueue.main.async { [self] in
            (self.cellControllers[grid!.getIndexPath(index: index).row] as? NodeCellController)?.cellReference?.isShortestPath = true
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var toReload = grid?.userTappedOnNode(index: indexPath) ?? []
        cellControllers = cellControllerFactory.cellControllers(with: (grid?.fetchAllNodes())!)
        toReload.append(indexPath)
        collectionView.reloadItems(at: toReload)
  
        
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
