//
//  CharactersService.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation
import Apollo

class CharactersService {

  static let shared = CharactersService()

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
}
