//
//  BaseGridSquare.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 15/01/2022.
//

import UIKit



class NodeCell: UICollectionViewCell {
    
    let visitedView: UIView = UIView()
    
    var isVisited = false {
        didSet {
            if isVisited {
                UIView.animate(withDuration: 1) {
                    self.visitedView.alpha = 1
                    self.visitedView.transform = .identity
                    self.visitedView.layer.cornerRadius = 0
                    self.visitedView.backgroundColor = UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.00)
                }
                UIView.animate(withDuration: 1, delay: 0.15) {
                    self.visitedView.backgroundColor = UIColor(red: 0.61, green: 0.35, blue: 0.71, alpha: 1.00)
                }
                UIView.animate(withDuration: 1, delay: 0.3) {
                    self.visitedView.backgroundColor = UIColor(red: 0.71, green: 0.20, blue: 0.44, alpha: 1.00)
                }
                UIView.animate(withDuration: 1, delay: 0.45) {
                    self.visitedView.backgroundColor = UIColor(red: 0.60, green: 0.00, blue: 0.54, alpha: 1.00)
                    self.layer.borderColor = UIColor(red: 0.60, green: 0.00, blue: 0.54, alpha: 1.00).cgColor
                }
            } else {
                backgroundColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.00)
                visitedView.alpha = 0
                visitedView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.visitedView.layer.cornerRadius = 50
                self.layer.borderColor = UIColor(red: 0.86, green: 0.87, blue: 0.88, alpha: 1.00).cgColor
            }
        }
    }
    
    var isShortestPath = false {
        didSet {
            if isShortestPath {
                UIView.animate(withDuration: 1) {
                    self.visitedView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    self.visitedView.backgroundColor = .shortestPathColor
                    self.layer.borderColor = UIColor.shortestPathColor.cgColor
                }
                UIView.animate(withDuration: 1) {
                    self.visitedView.transform = .identity
                }
            } else {
                
            }
        }
    }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(visitedView)
        visitedView.fillSuperview()
        visitedView.alpha = 0
        visitedView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        self.visitedView.backgroundColor = UIColor(red: 0.60, green: 0.00, blue: 0.54, alpha: 1.00)
        self.visitedView.layer.cornerRadius = 50
        
        self.layer.borderColor = UIColor(red: 0.86, green: 0.87, blue: 0.88, alpha: 1.00).cgColor
        self.layer.borderWidth = 0.5
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
