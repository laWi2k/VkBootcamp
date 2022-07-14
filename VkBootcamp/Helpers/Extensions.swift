//
//  Extensions.swift
//  VkBootcamp
//
//  Created by Daniel on 14.07.2022.
//

import UIKit

extension UIImageView {
    func load(url: String, completion: @escaping () -> () ) {
        if let url = URL(string: url){
            DispatchQueue.global().async {
                [weak self] in
                if let data = try? Data (contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            completion()
                        }
                    }
                }
            }
        }
    }
}

extension UIViewController {
    func alert(title: String?, text: String?) {
        let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true)
    }
}
