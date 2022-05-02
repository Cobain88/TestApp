//
//  CharactersViewController.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import UIKit

class CharactersViewController: BaseViewController<CharactersManager> {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegates()
        self.manager.viewControllerDidLoad()
    }
    
    override func setDelegates() {
        self.manager.viewControllerDelegate = self
    }

}

extension CharactersViewController: CharactersControllerDelegate {
    func setCharactersList(data: [CharactersModel]) {
        print(data.map({$0.species}))
    }
    
    
}
