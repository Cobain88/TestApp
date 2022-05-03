//
//  Extensions.swift
//  TestApp
//
//  Created by Dario Abete on 03/05/22.
//

import UIKit
import Foundation

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
