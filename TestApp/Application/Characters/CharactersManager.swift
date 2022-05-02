//
//  CharactersManager.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation

class CharactersManager: BaseManager, CharactersManagerDelegate {
    
    private var model: [CharactersModel] = []
    private var page: Int = 1
    weak var viewControllerDelegate: CharactersControllerDelegate!
    
    override func viewControllerDidLoad() {
        (self.viewControllerDelegate as? CharactersViewController)?.addSpinner()
        
        CharactersService.shared.apollo.fetch(query: GetCharQuery(page: page)) { result in
          switch result {
          case .success(let graphQLResult):
              
              guard let list = graphQLResult.data?.characters?.results else {
                  return
              }
              
              _ = list.compactMap { char in
                  self.model.append(CharactersModel(name: char?.name ?? "", gender: char?.gender ?? "", status: nil, species: char?.species ?? "", image: nil))
              }
              
              DispatchQueue.main.async {
                  (self.viewControllerDelegate as? CharactersViewController)?.removeSpinner()
                  self.viewControllerDelegate?.setCharactersList(data: self.model)
              }
              
              
              
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
    }
    
    func refresh() {
        self.page+=1
        self.viewControllerDidLoad()
    }
    
}
