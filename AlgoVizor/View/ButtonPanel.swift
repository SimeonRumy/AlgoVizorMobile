//
//  ButtonPanel.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 16/01/2022.
//

import UIKit

class ButtonPanel: UIView {
    
    // launch
    // set start
    // set end
    // add walls
    // select algo
    
    var lauchButton = UIButton(type: .system)
    var algoSelectionButton = UIButton(type: .system)
    //    var elementSelectionButton = UIButton(type: .system)
    
    
    var setStartButton = UIButton(type: .system)
    var setEndButton = UIButton(type: .system)
    var addWallButton = UIButton(type: .system)
    
    var algoPickerStack: UIStackView = UIStackView()
    var gridSettingStack: UIStackView = UIStackView()
    
    let label = UILabel()
    //    let label2 = UILabel()
    
    var isAlgoRunning = false
    
    let wrapView = UIView()
    //    let wrapView2 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lynxWhite
        addUIElements()
        addAlgoPickerStack()
        addSelectAlgorithmButton()
        addLauchButton()
        addButtonStack()
        addStartGridButton()
        addEndGridButton()
        addWallGridButton()
    }
    
    func addUIElements() {
        addSubview(wrapView)
        addSubview(gridSettingStack)
        addSubview(lauchButton)
        
    }
    
    func addAlgoPickerStack() {
        algoPickerStack.axis = .horizontal
        algoPickerStack.spacing = 20
        algoPickerStack.distribution = .equalCentering
        wrapView.addSubview(algoPickerStack)
        algoPickerStack.fillSuperview(padding: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        wrapView.centerXInSuperview()
        wrapView.anchor(top: topAnchor,
                        leading: leadingAnchor,
                        bottom: nil,
                        trailing: trailingAnchor,
                        padding: UIEdgeInsets(top: 10, left: 50, bottom: 10, right: 50))
        wrapView.backgroundColor = .systemGray5
        wrapView.layer.cornerRadius = 10
        wrapView.anchorHeigth(to: self, multiplier: 0.24)
        
    }
    
    func addButtonStack() {
        gridSettingStack.axis = .horizontal
        gridSettingStack.spacing = 5
        gridSettingStack.distribution = .fillEqually
//        gridSettingStack.anchorHeigth(to: self, multiplier: 0.25)
        gridSettingStack.anchor(top: wrapView.bottomAnchor,
                                leading: leadingAnchor,
                                bottom: nil,
                                trailing: trailingAnchor,
                                padding: UIEdgeInsets(top: 15, left: 5, bottom: 5, right: 5))
        
    }
    
    func addStartGridButton() {
        var config = UIButton.Configuration.tinted()
        config.title = "Set Start Point"
        config.image = UIImage(systemName: "arrow.up.right.square.fill")
        config.baseForegroundColor = .systemGreen
        config.baseBackgroundColor = .systemGreen
        config.imagePadding = 6
        config.imagePlacement = .trailing
        config.cornerStyle = .capsule
        config.titleAlignment = .center
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = incoming.font?.withSize(FontSizeCalculator.fontSize)
            return outgoing
        }
        setStartButton = UIButton(configuration: config, primaryAction: .none)
        gridSettingStack.addArrangedSubview(setStartButton)
        
    }
    
    func addEndGridButton() {
        var config = UIButton.Configuration.tinted()
        config.title = "Set End Point"
        config.image = UIImage(systemName: "arrow.down.right.square.fill")
        config.baseForegroundColor = .systemRed
        config.baseBackgroundColor = .systemRed
        config.imagePadding = 6
        config.imagePlacement = .trailing
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = incoming.font?.withSize(FontSizeCalculator.fontSize)
            return outgoing
        }
        setEndButton = UIButton(configuration: config, primaryAction: .none)
        gridSettingStack.addArrangedSubview(setEndButton)
    }
    
    func addWallGridButton() {
        
        var config = UIButton.Configuration.tinted()
        config.title = "Add Walls"
        config.image = UIImage(systemName: "square.grid.3x1.below.line.grid.1x2")
        config.baseForegroundColor = .systemBrown
        config.baseBackgroundColor = .systemBrown
        config.imagePadding = 6
        config.imagePlacement = .trailing
        config.cornerStyle = .capsule
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = incoming.font?.withSize(FontSizeCalculator.fontSize)
            return outgoing
        }
        
        addWallButton = UIButton(configuration: config, primaryAction: .none)
        gridSettingStack.addArrangedSubview(addWallButton)
    }
    
    func addLauchButton() {
        var config = UIButton.Configuration.gray()
        config.title = "Run"
        config.image = UIImage(systemName: "play.circle")
        config.baseForegroundColor = .systemPink
        //        config.baseBackgroundColor = .systemPink
        config.imagePadding = 6
        config.imagePlacement = .trailing
        //        config.showsActivityIndicator = true
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = incoming.font?.withSize(FontSizeCalculator.fontSize)
            return outgoing
        }
        lauchButton = UIButton(configuration: config, primaryAction: .none)
        addSubview(lauchButton)
        lauchButton.configurationUpdateHandler = { [unowned self] button in
            var conf = button.configuration
            conf?.showsActivityIndicator = self.isAlgoRunning
            button.configuration = conf
            
        }
        
        lauchButton.anchor(top: gridSettingStack.bottomAnchor,
                           leading: wrapView.leadingAnchor,
                           bottom: nil,
                           trailing: wrapView.trailingAnchor,
                           padding: UIEdgeInsets(top: 15, left: 50, bottom: 10, right: 50))
        lauchButton.centerXInSuperview()
        lauchButton = UIButton(configuration: config, primaryAction: .none)
        //        lauchButton.anchorHeigth(to: self, multiplier: 0.25)
    }
    
    
    
    func addSelectAlgorithmButton() {
        
        let add = UIAction(title: "Dijkstra") { (action) in
            print("Add")
        }
        let edit = UIAction(title: "A-Star") { (action) in
            print("Edit")
        }
        let delete = UIAction(title: "BFS") { (action) in
            print("Delete")
        }
        
        let menu = UIMenu(title: "Menu", children: [add, edit, delete])
        algoSelectionButton.menu = menu
        algoSelectionButton.showsMenuAsPrimaryAction = true
        algoSelectionButton.changesSelectionAsPrimaryAction = true
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.title = "Select Algorithm"
        config.baseForegroundColor = .systemBlue
        //        config.baseBackgroundColor = .systemBlue
        config.imagePadding = 6
        config.imagePlacement = .trailing
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = incoming.font?.withSize(FontSizeCalculator.fontSize)
            return outgoing
        }
        algoSelectionButton.configuration = config
        label.font = label.font.withSize(FontSizeCalculator.fontSize)
        label.text = "Selected Algorithm"
        algoPickerStack.addArrangedSubview(label)
        algoPickerStack.addArrangedSubview(algoSelectionButton)
        
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
