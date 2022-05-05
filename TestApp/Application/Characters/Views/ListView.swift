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
    
    @IBOutlet weak var tableView: UITableView!
    
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
        view?.refreshControl.tintColor = .clear
        view?.tableView.addSubview(view!.refreshControl)
        view?.isRefreshing = false
        view?.tableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: CharacterTableViewCell.identifier)
        view?.tableView.dataSource = view
        view?.tableView.delegate = view
        view?.tableView.separatorStyle  = .none
        view?.tableView.reloadData()
        return view!
    }
    
    @objc func refresh() {
        self.delegate?.refresh()
        self.isRefreshing = true
    }
}


extension ListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let verticalPadding: CGFloat = 8

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 6
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
       cell.setup(model: self.list[indexPath.row])
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didTapOnItem(model: self.list[indexPath.row])
    }
}
