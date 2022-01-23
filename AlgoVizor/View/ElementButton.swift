//
//  ElementButton.swift
//  AlgoVizor
//
//  Created by Simeon Rumyannikov on 18/01/2022.
//

import UIKit

class ElementButton: UIButton {
    
    var config = UIButton.Configuration.tinted()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config.imagePadding = 6
        config.imagePlacement = .trailing
        config.cornerStyle = .capsule
        config.titleAlignment = .center
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: FontSizeCalculator.fontSize)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = incoming.font?.withSize(FontSizeCalculator.fontSize)
            return outgoing
        }
        
        self.configuration = config
        changesSelectionAsPrimaryAction = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
