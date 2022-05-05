//
//  TestingService.swift
//  TestAppTests
//
//  Created by Dario Abete on 05/05/22.
//

import Foundation
import TestApp

struct ResultModel: Codable {
    var results: [CharacterModel]
    
    init(results: [CharacterModel]) {
        self.results = results
    }
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

class TestingService {
    
    static let shared = TestingService()
    
    func decode(_ data: Data?, error: Error?) -> CustomResult<ResultModel> {
        guard error == nil else {
            return (.failure(MyError.responseError))
        }
        
        guard let data = data else {
            return (.failure(MyError.noData))
        }
        
        do {
            let list = try JSONDecoder().decode(ResultModel.self, from: data)
            return (.success(list))
        } catch {
            return(.failure(error))
        }
    }
}





