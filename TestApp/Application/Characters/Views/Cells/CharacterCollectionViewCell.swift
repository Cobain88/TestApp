//
//  CharacterCollectionViewCell.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    static let identifier = "CharacterCollectionViewCell"
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.name.text = nil
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1.5
    }
    
    func setup(model: CharactersModel?) {
        guard let model = model else { return }
        self.name.text = model.name
    }

}
