//
//  TableViewCell.swift
//  VkBootcamp
//
//  Created by Daniel on 13.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = "TableViewCell"
    
    //MARK: - Variables
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    let appName = VKLabel(text: "App", font: .systemFont(ofSize: 18))
    var appIcon = VKImageView(cornerRadius: 13)
    let appDescription = VKLabel(text: "Some text to simulate filling of the container", font: .systemFont(ofSize: 12), numberOfLines: 2)
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        addSubview(appIcon)
        appIcon.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        addSubview(appName)
        addSubview(appDescription)
        
        NSLayoutConstraint.activate([
            appIcon.widthAnchor.constraint(equalToConstant: 64),
            appIcon.heightAnchor.constraint(equalToConstant: 64),
            appIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            appIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: appIcon.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: appIcon.centerYAnchor),
            
            appName.topAnchor.constraint(equalTo: appIcon.topAnchor),
            appName.leadingAnchor.constraint(equalTo: appIcon.trailingAnchor, constant: 16),
            appName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            
            appDescription.topAnchor.constraint(equalTo: appName.bottomAnchor, constant: 10),
            appDescription.leadingAnchor.constraint(equalTo: appName.leadingAnchor),
            appDescription.trailingAnchor.constraint(equalTo: appName.trailingAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
