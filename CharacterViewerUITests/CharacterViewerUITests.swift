//
//  CharacterViewerUITests.swift
//  CharacterViewerUITests
//
//  Created by ORLANDO RIVERA on 10/14/17.
//  Copyright © 2017 DigitalSummit. All rights reserved.
//

import XCTest

class CharacterViewerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUIExample() {
        
        let app = XCUIApplication()
        app.alerts["What Show do you want to explore?"].buttons["Seinfeld"].tap()
        
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Cosmo Kramer ").children(matching: .image).element.tap()
        
        let backButton = app.navigationBars["Detail"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        backButton.tap()
        
        let tvShowsNavigationBar = app.navigationBars["TV Shows"]
        let listButton = tvShowsNavigationBar.buttons["List"]
        listButton.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Elaine Benes ").children(matching: .image).element.tap()
        backButton.tap()
        listButton.tap()
        tvShowsNavigationBar.buttons["Columns(2/3)"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Jerry Seinfeld (character) ").children(matching: .image).element.tap()
        backButton.tap()
        XCTAssert(cellsQuery.otherElements.containing(.staticText, identifier:"Jerry Seinfeld (character) ").element.exists)



    }
    
    func testUIExample2() {
        
        let app = XCUIApplication()
        app.alerts["What Show do you want to explore?"].buttons["Simpsons"].tap()
        
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Homer Simpson ").children(matching: .image).element.tap()
        
        let backButton = app.navigationBars["Detail"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        backButton.tap()
        
        let tvShowsNavigationBar = app.navigationBars["TV Shows"]
        tvShowsNavigationBar.buttons["Columns(2/3)"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Barney Gumble ").children(matching: .image).element.tap()
        backButton.tap()
        tvShowsNavigationBar.buttons["List"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Chief Wiggum ").children(matching: .image).element.tap()
        backButton.tap()
        XCTAssert(cellsQuery.otherElements.containing(.staticText, identifier:"Chief Wiggum ").element.exists)
        
    }
    
    func testUIExample3() {
        
        let app = XCUIApplication()
        app.alerts["What Show do you want to explore?"].buttons["Simpsons"].tap()
        
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Chief Wiggum ").children(matching: .image).element.tap()
        
        let backButton = app.navigationBars["Detail"].children(matching: .button).matching(identifier: "Back").element(boundBy: 0)
        backButton.tap()
        
        let tvShowsNavigationBar = app.navigationBars["TV Shows"]
        let listButton = tvShowsNavigationBar.buttons["List"]
        listButton.tap()
        tvShowsNavigationBar.buttons["TV Shows"].tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"George Costanza ").children(matching: .image).element.tap()
        backButton.tap()
        listButton.tap()
        XCTAssert(cellsQuery.otherElements.containing(.staticText, identifier:"George Costanza ").element.exists)
        
    }
    
}
