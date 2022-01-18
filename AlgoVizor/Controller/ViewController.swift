//
//  ViewController.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit

class ViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func loadView() {
        view = MainView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
    }
    
    func setupDelegates() {
        guard let mainView = view as? MainView else { return }
        mainView.grid.delegate = self
    }


}

extension ViewController: GridViewDelegate {
    
    func userSelectedGrid(gridIndex: GridIndex) {
        print(gridIndex)
    }
    
}
