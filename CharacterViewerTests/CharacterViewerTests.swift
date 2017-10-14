//
//  CharacterViewerTests.swift
//  CharacterViewerTests
//
//  Created by ORLANDO RIVERA on 10/14/17.
//  Copyright © 2017 DigitalSummit. All rights reserved.
//

import XCTest
@testable import CharacterViewer

class CharacterViewerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimpsonsCall() {
        let expectation = XCTestExpectation(description: "Character Simpsons test calls")

        let baseUrl = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"

        CharAPI.shared.fetchResults(for: baseUrl) { items in
            XCTAssertNotNil(items, "No data was downloaded.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testSeinfeldCall() {
        let expectation = XCTestExpectation(description: "Character Seinfeld test calls")
        
        let baseUrl = "http://api.duckduckgo.com/?q=seinfeld+characters&format=json"

        CharAPI.shared.fetchResults(for: baseUrl) { items in
            XCTAssertNotNil(items, "No data was downloaded.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
