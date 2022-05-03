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
                    return
                }
                
                _ = list.compactMap({ loc in
                    self.model?.location = Location(name: loc?.name ?? "", dimension: loc?.dimension ?? "", residents: loc?.residents.count ?? 0)
                })
                
                
                
                if let model = self.model {
                    self.setModel(model: model)
                    (self.viewControllerDelegate as? DetailViewController)?.removeSpinner()
                    self.viewControllerDelegate?.setDetailView(model: model)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func setModel(model: CharacterModel) {
        self.model = model 
    }
}
