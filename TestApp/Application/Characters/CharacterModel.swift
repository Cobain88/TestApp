//
//  CharactersModel.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation

public struct CharacterModel: Codable {
    var id: String?
    var name: String?
    var gender: String?
    var status: String?
    var species: String?
    var image: String?
    var origin: Origin?
    var location: Location?
    var firstAppear: String?
    var firstAppearCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case status
        case species
        case image
    }
    
    init(id: String?, name: String?, gender: String?, status: String?, species: String?, image: String?, origin: Origin?, location: Location?) {
        self.id = id
        self.name = name
        self.gender = gender
        self.status = status
        self.species = species
        self.image = image
        self.origin = origin
        self.location = location
    }

}

struct Origin {
    var name: String?
}

struct Location {
    var name: String?
    var dimension: String?
    var residents: Int?
}
