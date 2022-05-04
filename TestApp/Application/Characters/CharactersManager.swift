//
//  CharactersManager.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation

class CharactersManager: BaseManager, CharactersManagerDelegate {
    
    private var model: [CharacterModel] = []
    private var page: Int = 1
    weak var viewControllerDelegate: CharactersControllerDelegate!
    
    override func viewControllerDidLoad() {
        (self.viewControllerDelegate as? CharactersViewController)?.addSpinner()
        
        CharactersService.shared.apollo.fetch(query: GetCharacterQuery(page: page)) { result in
          switch result {
          case .success(let graphQLResult):
              
              guard let list = graphQLResult.data?.characters?.results else {
                  return
              }
              
              _ = list.compactMap { char in
                  self.model.append(CharacterModel(id: char?.id, name: char?.name ?? "", gender: char?.gender ?? "", status: char?.status ?? "", species: char?.species ?? "", image: char?.image ?? "", origin: Origin(name: char?.origin?.name ?? ""), location: Location(name: char?.location?.name ?? "")))
              }
              
              DispatchQueue.main.async {
                  (self.viewControllerDelegate as? CharactersViewController)?.removeSpinner()
                  self.setModel(model: self.model)
                  self.viewControllerDelegate?.setCharactersList(data: self.model)
                  self.viewControllerDelegate?.setNavigationController()
              }
              
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
    }
    
    func setModel(model: [CharacterModel]) {
        self.model = model
    }
    
    func didTapOnCharacter(model: CharacterModel) {
        guard let detailVC = DetailViewController.createStoryboardInstance() else { return }
        detailVC.setModel(model: model)
        self.viewControllerDelegate?.goToDetailView(controller: detailVC)
    }
    
    func refresh() {
        self.page += 1
        self.viewControllerDidLoad()
    }
    
}
