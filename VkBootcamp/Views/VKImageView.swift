//
//  VKImageView.swift
//  VkBootcamp
//
//  Created by Daniel on 13.07.2022.
//

import UIKit

class VKImageView: UIImageView {

    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
