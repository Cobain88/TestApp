//
//  Extensions.swift
//  TestApp
//
//  Created by Dario Abete on 03/05/22.
//

import UIKit
import Foundation

extension UIViewController {
    func showAlert(message: String, completion: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIImageView {
    func setImage(from url: URL?, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        guard let url = url else { return }
        
        ImageLoader.shared.loadImage(for: url) { (image, error) in
            if let _ = error {
                return
            }
            
            if let image = image {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
