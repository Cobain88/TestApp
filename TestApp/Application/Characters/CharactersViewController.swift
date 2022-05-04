//
//  CharactersViewController.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import UIKit

class CharactersViewController: BaseViewController<CharactersManager> {

    @IBOutlet weak var characterListView: UIView!
    
    var listView: ListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegates()
        self.manager.viewControllerDidLoad()
    }
    
    override func setDelegates() {
        self.manager.viewControllerDelegate = self
    }

}

extension CharactersViewController: CharactersControllerDelegate {
    
    func setCharactersList(data: [CharacterModel]) {
        self.listView?.removeFromSuperview()
        self.listView = ListView.create(data: data, delegate: self)
        if let listView = self.listView {
            characterListView.addSubview(listView)
            listView.translatesAutoresizingMaskIntoConstraints = false
            listView.leadingAnchor.constraint(equalTo: characterListView.leadingAnchor).isActive = true
            listView.trailingAnchor.constraint(equalTo: characterListView.trailingAnchor).isActive = true
            listView.topAnchor.constraint(equalTo: characterListView.topAnchor).isActive = true
            listView.bottomAnchor.constraint(equalTo: characterListView.bottomAnchor).isActive = true
        }
    }
    
    func setNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Characters"
    }
    
    func goToDetailView(controller: DetailViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension CharactersViewController: CharacterViewDelegate {
   
    func didTapOnItem(model: CharacterModel) {
        self.manager.didTapOnCharacter(model: model)
    }
    
    func refresh() {
        self.manager.refresh()
    }
    
    
}
