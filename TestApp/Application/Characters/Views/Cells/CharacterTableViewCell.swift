//
//  CharacterTableViewCell.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

    static let identifier = "CharacterTableViewCell"
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.characterImageView.image = nil
        self.nameLabel.text = nil
        self.speciesLabel.text = nil
        self.statusLabel.text = nil
     
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    func setup(model: CharacterModel?) {
        guard let model = model else { return }
        if let imageString = model.image {
            self.characterImageView.setImage(from: URL(string: imageString))
        }
        self.nameLabel.text = model.name
        self.speciesLabel.text = model.species
        self.statusLabel.text = model.status
        self.statusImageView.clipsToBounds = true
        self.statusImageView.layer.cornerRadius = 8
        self.statusImageView.backgroundColor = {
            switch model.status?.lowercased() {
                case "alive" : return .green
                case "dead" : return .red
                default: return .gray
            }
        }()
    }
}
