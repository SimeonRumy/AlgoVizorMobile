//
//  ButtonPanel.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 16/01/2022.
//

import UIKit

class ButtonPanel: UIView {
    
    var lauchButton = UIButton(type: .system)
    var algoSelectionButton = UIButton(type: .system)
    
    var setStartButton = ElementButton()
    var setEndButton = ElementButton()
    var addWallButton = ElementButton()
    
    var algoPickerStack: UIStackView = UIStackView()
    var gridSettingStack: UIStackView = UIStackView()
    
    let selectAlgorithmLabel = UILabel()
    var isAlgoRunning = false
    let wrapView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lynxWhite
        addUIElements()
        addAlgoPickerStack()
        setupLabel()
        addSelectAlgoButton()
        addLauchButton()
        addElementSelectionButtons()
    }
    
    func addUIElements() {
        addSubview(wrapView)
        addSubview(gridSettingStack)
        addSubview(lauchButton)
    }
    
    private func addElementSelectionButtons() {
        addButtonStack()
        addStartGridButton()
        addEndGridButton()
        addWallGridButton()
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
//        wrapView.anchorHeigth(to: self, multiplier: 0.24)
        
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
        setStartButton.configuration?.title = "Set Start Point"
        setStartButton.configuration?.image = UIImage(systemName: "arrow.up.right.square.fill")
        setStartButton.configuration?.baseForegroundColor = .systemGreen
        setStartButton.configuration?.baseBackgroundColor = .systemGreen
        gridSettingStack.addArrangedSubview(setStartButton)
        
    }
    
    func addEndGridButton() {
        setEndButton.configuration?.title = "Set End Point"
        setEndButton.configuration?.image = UIImage(systemName: "arrow.down.right.square.fill")
        setEndButton.configuration?.baseForegroundColor = .systemRed
        setEndButton.configuration?.baseBackgroundColor = .systemRed
        gridSettingStack.addArrangedSubview(setEndButton)
    }
    
    func addWallGridButton() {
        addWallButton.configuration?.title = "Add Walls"
        addWallButton.configuration?.image = UIImage(systemName: "square.grid.3x1.below.line.grid.1x2")
        addWallButton.configuration?.baseForegroundColor = .systemBrown
        addWallButton.configuration?.baseBackgroundColor = .systemBrown
        gridSettingStack.addArrangedSubview(addWallButton)
    }
    
    func addLauchButton() {
        lauchButton = UIButton(configuration: configureLaunchButton(), primaryAction: .none)
        lauchButton.configurationUpdateHandler = { [unowned self] button in
            var conf = button.configuration
            conf?.showsActivityIndicator = self.isAlgoRunning
            button.configuration = conf
            
        }
        addSubview(lauchButton)
        lauchButton.anchor(top: gridSettingStack.bottomAnchor,
                           leading: wrapView.leadingAnchor,
                           bottom: nil,
                           trailing: wrapView.trailingAnchor,
                           padding: UIEdgeInsets(top: 15, left: 50, bottom: 10, right: 50))
        lauchButton.centerXInSuperview()
        //        lauchButton.anchorHeigth(to: self, multiplier: 0.25)
    }
    
    func configureLaunchButton() -> UIButton.Configuration {
        var config = UIButton.Configuration.gray()
        config.title = "Start"
        config.image = UIImage(systemName: "play.circle")
        config.baseForegroundColor = .systemPink
        config.imagePadding = 6
        config.imagePlacement = .trailing
        //        config.showsActivityIndicator = true
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = incoming.font?.withSize(FontSizeCalculator.fontSize)
            return outgoing
        }
        return config
    }
    
    
    
    
    func addSelectAlgoButton() {
        algoSelectionButton.menu = setupAlgoMenu()
        algoSelectionButton.configuration = configureAlgoButton()
        algoSelectionButton.showsMenuAsPrimaryAction = true
        algoSelectionButton.changesSelectionAsPrimaryAction = true
        algoPickerStack.addArrangedSubview(algoSelectionButton)
        
    }
    
    func configureAlgoButton() -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.baseForegroundColor = .systemBlue
        config.imagePadding = 6
        config.imagePlacement = .trailing
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = incoming.font?.withSize(FontSizeCalculator.fontSize)
            return outgoing
        }
        return config

    }
    
    func setupAlgoMenu() -> UIMenu {
        let dijkstra = UIAction(title: "Dijkstra") { (action) in
            print("Add")
        }
        let astar = UIAction(title: "A-Star") { (action) in
            print("Edit")
        }
        let bfs = UIAction(title: "BFS") { (action) in
            print("Delete")
        }
        let dfs = UIAction(title: "BFS") { (action) in
            print("Delete")
        }
        
        let menu = UIMenu(title: "Menu", children: [dijkstra, astar, bfs, dfs])
        return menu
    }
    
    private func setupLabel() {
        selectAlgorithmLabel.font = selectAlgorithmLabel.font.withSize(FontSizeCalculator.fontSize)
        selectAlgorithmLabel.text = "Selected Algorithm"
        algoPickerStack.addArrangedSubview(selectAlgorithmLabel)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
