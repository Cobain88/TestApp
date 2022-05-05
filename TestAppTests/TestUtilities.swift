//
//  TestUtilities.swift
//  TestAppTests
//
//  Created by Dario Abete on 05/05/22.
//

import Foundation

enum CustomResult<Value> {
    case success(Value)
    case failure(Error)
}

enum MyError: Error {
    case responseError
    case noData
    case wrongUrl
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .responseError:
            return "An error has occurred"
        case .noData:
            return "No data fetched"
        case .wrongUrl:
            return "Wrong URL"
        }
    }
}

enum MyTestError: Error {
    case mock
}
