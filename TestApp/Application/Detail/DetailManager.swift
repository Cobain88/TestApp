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
            (self.viewControllerDelegate as? DetailViewController)?.removeSpinner()
            return
        }
        
        CharactersService.shared.apollo.fetch(query: GetLocationsQuery(location: location)) { result in
            switch result {
                
            case .success(let graphQLResult):
                guard let list = graphQLResult.data?.locations?.results else {
                    (self.viewControllerDelegate as? DetailViewController)?.removeSpinner()
                    return
                }
                
                _ = list.compactMap({ loc in
                    self.model?.location = Location(name: loc?.name ?? "", dimension: loc?.dimension ?? "", residents: loc?.residents.count ?? 0)
                })
                
                CharactersService.shared.apollo.fetch(query: GetEpisodePerCharacterQuery()) { result in
                    switch result {
                        
                    case .success(let graphQLResult):
                        guard let list = graphQLResult.data?.episodes?.results else {
                            (self.viewControllerDelegate as? DetailViewController)?.removeSpinner()
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
                        (self.viewControllerDelegate as? DetailViewController)?.removeSpinner()
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                (self.viewControllerDelegate as? DetailViewController)?.removeSpinner()
            }
            
        }
    }
    
    func setModel(model: CharacterModel) {
        self.model = model 
    }
}
