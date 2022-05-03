//
//  ListView.swift
//  TestApp
//
//  Created by Dario Abete on 02/05/22.
//

import Foundation
import UIKit

protocol CharacterViewDelegate: AnyObject {
    func didTapOnItem(model: CharacterModel)
    func refresh()
}

class ListView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: CharacterViewDelegate?
    
    var list: [CharacterModel] = []
    var refreshControl = UIRefreshControl()
    
    var isRefreshing: Bool = false {
        didSet {
            if !isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func create(data: [CharacterModel], delegate: CharacterViewDelegate) -> ListView {
        let nib = UINib(nibName: "ListView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? ListView
        view?.list = data
        view?.delegate = delegate
        view?.refreshControl.addTarget(view, action: #selector(view?.refresh), for: .valueChanged)
        view?.collectionView.addSubview(view!.refreshControl)
        view?.isRefreshing = false
        view?.collectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        view?.collectionView.dataSource = view
        view?.collectionView.delegate = view
        view?.collectionView.reloadData()
        return view!
    }
    
    @objc func refresh() {
        self.delegate?.refresh()
        self.isRefreshing = true
    }
}

extension ListView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        cell.setup(model: self.list[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didTapOnItem(model: self.list[indexPath.row])
    }
}

extension ListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 2 - 4
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
}
