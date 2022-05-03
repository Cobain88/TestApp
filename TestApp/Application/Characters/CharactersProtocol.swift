//
//  CharactersProtocol.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation

protocol CharactersManagerDelegate: AnyObject {
    func refresh()
    func didTapOnCharacter(model: CharacterModel)
}

protocol CharactersControllerDelegate: AnyObject {
    func setCharactersList(data: [CharacterModel])
    func goToDetailView(controller: DetailViewController)
}
