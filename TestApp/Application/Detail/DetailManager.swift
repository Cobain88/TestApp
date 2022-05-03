//
//  DetailManager.swift
//  TestApp
//
//  Created by Dario Abete on 03/05/22.
//

import Foundation
import UIKit

class DetailManager: BaseManager, DetailManagerDelegate {
    
    private var model: CharacterModel?
    weak var viewControllerDelegate: DetailControllerDelegate!
    
    override func viewControllerDidLoad() {
        if let model = self.model {
            self.viewControllerDelegate?.setDetailView(model: model)
        }
    }
    
    func setModel(model: CharacterModel) {
        self.model = model 
    }
}
