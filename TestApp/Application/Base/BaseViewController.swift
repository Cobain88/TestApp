//
//  BaseViewController.swift
//  TestApp
//
//  Created by Dario Abete on 28/04/22.
//

import UIKit

class BaseViewController<T: BaseManager>: UIViewController, BaseControllerDelegate {
    
    var manager: T
    let spinner = UIActivityIndicatorView(style: .large)
    
    required init(mng: T) {
        manager = mng
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        manager = T()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setDelegates() {}
    
    func addSpinner() {
        view.addSubview(spinner)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.startAnimating()
    }
    
    func removeSpinner() {
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
        spinner.removeFromSuperview()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
