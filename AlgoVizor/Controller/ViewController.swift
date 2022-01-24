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
            mainView.panel.isAlgoRunning = true
            algo.run(updateViewDuringRun: { index in
//                cellControllers = self.cellControllerFactory.cellControllers(with: (grid?.fetchAllNodes())!)
                DispatchQueue.main.async {
                    (cellControllers[grid!.getIndexPath(index: index).row] as? NodeCellController)?.cellReference?.isVisited = true
//                    mainView.grid.grid.reloadData()
//                    mainView.grid.grid.reloadItems(at: [grid!.getIndexPath(index: index)])
//                    mainView.grid.grid.collectionViewLayout.invalidateLayout()
//                    mainView.grid.grid.layoutSubviews()
                }
            }, updateViewOnCompletion: {
                mainView.panel.isAlgoRunning = false
                mainView.panel.lauchButton.setNeedsUpdateConfiguration()
            })
        }), for: .touchUpInside)
        
        mainView.panel.addWallButton.addAction(UIAction(handler: { [unowned self] action in
            grid?.elementSelectionStateChanged(state: .Wall)
        }), for: .touchUpInside)
        
        mainView.panel.setStartButton.addAction(UIAction(handler: { [unowned self] action in
            grid?.elementSelectionStateChanged(state: .Start)
        }), for: .touchUpInside)
        
        mainView.panel.setEndButton.addAction(UIAction(handler: { [unowned self] action in
            grid?.elementSelectionStateChanged(state: .End)
        }), for: .touchUpInside)
        
        mainView.panel.resetGridButton.addAction(UIAction(handler: { [unowned self] action in
            grid?.resetAllNodes()
            mainView.grid.grid.reloadData()
        }), for: .touchUpInside)
        
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
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
//            cell.transform = .identity
//        })
//    }
    
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


enum ElementState {
    case Wall
    case Start
    case End
}

