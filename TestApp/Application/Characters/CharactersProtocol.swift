//
//  CharactersProtocol.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation

protocol CharactersManagerDelegate: AnyObject {
    func setModel(model: [CharacterModel])
    func didTapOnCharacter(model: CharacterModel)
    func refresh()
    
}

protocol CharactersControllerDelegate: AnyObject {
    func setCharactersList(data: [CharacterModel])
    func goToDetailView(controller: DetailViewController)
}
