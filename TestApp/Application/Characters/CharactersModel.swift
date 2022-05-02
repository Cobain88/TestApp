//
//  CharactersModel.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation

struct CharactersModel {
    var name: String?
    var gender: String?
    var status: String?
    var origin: String?
    var species: String?
    var image: String?
    
    init(name: String?, gender: String?, status: String?, origin: String?, species: String?, image: String?) {
        self.name = name
        self.gender = gender
        self.status = status
        self.origin = origin
        self.species = species
        self.image = image
    }
}