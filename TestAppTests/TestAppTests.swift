//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Dario Abete on 28/04/22.
//

import XCTest
@testable import TestApp

class TestAppTests: XCTestCase {

    //Waiting for a success
        func testDecodeResponse() {
            
            let jsonString = "{\"results\": [{\"id\": \"1\",\"name\":\"Rick Sanchez\",\"status\":\"Alive\",\"species\": \"Human\",\"gender\":\"Male\",\"image\": \"https://rickandmortyapi.com/api/character/avatar/1.jpeg\"}]}"
            
            guard let data = jsonString.setAsJSON else {
                XCTFail()
                return
            }
            
            let result = TestingService.shared.decode(data, error: nil)

            switch result {
            case .failure(_):
                XCTFail("Success expected")
            case .success(let list):
                XCTAssertNotNil(list)
                XCTAssertEqual(1, list.results.count)
                if let character = list.results.first {
                    XCTAssertEqual("Rick Sanchez", character.name)
                    XCTAssertEqual("Alive", character.status)
                }
            }
        }
    
    
    //Waiting for afailure (data is equal to nil)
    func testDecodeWrongDataResponse() {
        let result = TestingService.shared.decode(nil, error: nil)

        switch result {
        case .failure(let error):
            XCTAssertNotNil(error)
            XCTAssertEqual("No data fetched", error.localizedDescription)
        case .success(_):
            XCTFail("Failure expected")
        }
    }

    
    //Waiting for a failure (error is not equal to nil)
    func testDecodeResponseError() {
        let result = TestingService.shared.decode(Data(), error: MyTestError.mock)

        switch result {
        case .failure(let error):
            XCTAssertNotNil(error)
            XCTAssertEqual("An error has occurred", error.localizedDescription)
        case .success(_):
            XCTFail("Failure expected")
        }
    }

}
