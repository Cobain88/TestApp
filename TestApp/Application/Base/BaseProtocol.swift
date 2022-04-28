//
//  BaseProtocol.swift
//  TestApp
//
//  Created by Dario Abete on 28/04/22.
//

import Foundation

protocol BaseManagerDelegate: AnyObject {
    func viewControllerDidLoad()
}

protocol BaseControllerDelegate: AnyObject {
    func setDelegates()
    func addSpinner()
    func removeSpinner()
}
