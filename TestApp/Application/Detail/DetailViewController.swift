//
//  DetailViewController.swift
//  TestApp
//
//  Created by Dario Abete on 03/05/22.
//

import UIKit

enum CharacterInfoType {
    case status
    case gender
    case species
    case origin
    case location
    case locationDimensions
    case locationResidents
    case firstAppear
}

class DetailViewController: BaseViewController<DetailManager> {

    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterInfoStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegates()
        self.manager.viewControllerDidLoad()
    }
    
    override func setDelegates() {
        self.manager.viewControllerDelegate = self
    }
    
    public class func createStoryboardInstance() -> DetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
    }
}

extension DetailViewController: DetailControllerDelegate {
    
    func setModel(model: CharacterModel) {
        self.manager.setModel(model: model)
    }
    
    func setDetailView(model: CharacterModel) {
        self.characterName.text = model.name
        
        if let imageString = model.image {
            self.characterImage.setImage(from: URL(string: imageString))
        }
        
        if let status = model.status {
            self.addCharacterInfo(info: status, infoType: .status)
        }
        
        if let gender = model.gender {
            self.addCharacterInfo(info: gender, infoType: .gender)
        }
        
        if let species = model.species {
            self.addCharacterInfo(info: species, infoType: .species)
        }
        
        if let origin = model.origin?.name {
            self.addCharacterInfo(info: origin, infoType: .origin)
        }
        
        if let location = model.location {
            self.addCharacterInfo(info: location.name ?? "", infoType: .location)
            self.addCharacterInfo(info: location.dimension ?? "", infoType: .locationDimensions)
            self.addCharacterInfo(info: "\(location.residents ?? 0)", infoType: .locationResidents)
        }
        
        if let firstAppear = model.firstAppear, let firstAppearCode = model.firstAppearCode {
            let firstAppearString = firstAppear + " (\(firstAppearCode))"
            self.addCharacterInfo(info: firstAppearString, infoType: .firstAppear)
        }
    }
    
    private func addCharacterInfo(info: String, infoType: CharacterInfoType) {
        let infoLabel = UILabel()
        
        switch infoType {
        case .status:
            infoLabel.text = "Status: "
        case .gender:
            infoLabel.text = "Gender: "
        case .species:
            infoLabel.text = "Species: "
        case .origin:
            infoLabel.text = "Origin: "
        case .location:
            infoLabel.text = "Location: "
        case .locationDimensions:
            infoLabel.text = "Dimension: "
        case .locationResidents:
            infoLabel.text = "Residents: "
        case .firstAppear:
            infoLabel.text = "First appear: "
        }
        
        infoLabel.text! += info
        infoLabel.textColor = .white
        infoLabel.numberOfLines = 0
        infoLabel.adjustsFontSizeToFitWidth = true 
        characterInfoStackView.addArrangedSubview(infoLabel)
    }
    
    func goBackToListViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
