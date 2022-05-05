//
//  Extensions.swift
//  TestAppTests
//
//  Created by Dario Abete on 05/05/22.
//

import Foundation

extension String {
    
    var setAsJSON: Data? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
         return data
    }
}
