//
//  DetailManager.swift
//  TestApp
//
//  Created by Dario Abete on 03/05/22.
//

import Foundation
import UIKit

class DetailManager: BaseManager, DetailManagerDelegate {
    
    private var model: CharacterModel?
    weak var viewControllerDelegate: DetailControllerDelegate!
    
    override func viewControllerDidLoad() {
        (self.viewControllerDelegate as? DetailViewController)?.addSpinner()
        
        guard let location = model?.location?.name else {
            self.handleError(message: "Location data missing. Try again")
            return
        }
        
        CharactersService.shared.apollo.fetch(query: GetLocationsQuery(location: location)) { result in
            switch result {
                
            case .success(let graphQLResult):
                guard let list = graphQLResult.data?.locations?.results, list.count > 0 else {
                    self.handleError(message: "No locations found. Try again")
                    return
                }
                
                _ = list.compactMap({ loc in
                    self.model?.location = Location(name: loc?.name ?? "", dimension: loc?.dimension ?? "", residents: loc?.residents.count ?? 0)
                })
                
                CharactersService.shared.apollo.fetch(query: GetEpisodePerCharacterQuery()) { result in
                    switch result {
                        
                    case .success(let graphQLResult):
                        guard let list = graphQLResult.data?.episodes?.results, list.count > 0 else {
                            self.handleError(message: "No episodes found. Try again ")
                            return
                        }
                        
                        let episodeList = list.filter { episode in
                            return episode!.characters.contains(where: { char in
                                char!.id == self.model?.id
                            })
                        }
                        
                        if let firstAppear = episodeList.first {
                            self.model?.firstAppear = firstAppear?.name
                            self.model?.firstAppearCode = firstAppear?.episode
                        }
                        
                        if let model = self.model {
                            self.setModel(model: model)
                            self.viewControllerDelegate?.setDetailView(model: model)
                        }
                        
                        (self.viewControllerDelegate as? DetailViewController)?.removeSpinner()
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.handleError(message: "There was an error in fetching the episode data. Try again")
                        }
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.handleError(message: "There was an error in fetching the location data. Try again")
                }
            }
            
        }
    }
    
    func setModel(model: CharacterModel) {
        self.model = model
    }
    
    private func handleError(message: String) {
        (self.viewControllerDelegate as? DetailViewController)?.removeSpinner()
        (self.viewControllerDelegate as? DetailViewController)?.showAlert(message: message, completion: { _ in
            self.viewControllerDelegate?.goBackToListViewController()
        })
    }
}
