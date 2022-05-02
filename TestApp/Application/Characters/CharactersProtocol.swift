//
//  CharactersProtocol.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation

protocol CharactersManagerDelegate: AnyObject {

}

protocol CharactersControllerDelegate: AnyObject {
    func setCharactersList(data: [CharactersModel])

}
