//
//  CharacterCollectionViewCell.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    static let identifier = "CharacterCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameLabel.text = nil
        self.speciesLabel.text = nil
        self.imageView.alpha = 0.8
    }
    
    func setup(model: CharactersModel?) {
        guard let model = model else { return }
        self.nameLabel.text = model.name
        self.speciesLabel.text = model.species
        if let imageString = model.image {
            self.imageView.setImage(from: URL(string: imageString))
        }
        
    }

}
