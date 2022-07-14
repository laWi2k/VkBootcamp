//
//  VKLabel.swift
//  VkBootcamp
//
//  Created by Daniel on 13.07.2022.
//

import UIKit

class VKLabel: UILabel {

    // MARK: - Initialization
    init(text: String, font: UIFont, numberOfLines: Int = 1) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
