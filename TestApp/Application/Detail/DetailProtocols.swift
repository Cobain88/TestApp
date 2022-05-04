//
//  DetailProtocols.swift
//  TestApp
//
//  Created by Dario Abete on 03/05/22.
//

import Foundation
import UIKit


protocol DetailManagerDelegate: AnyObject {
    func setModel(model: CharacterModel)
}

protocol DetailControllerDelegate: AnyObject {
    func setModel(model: CharacterModel)
    func setDetailView(model: CharacterModel)
    func goBackToListViewController()
}
