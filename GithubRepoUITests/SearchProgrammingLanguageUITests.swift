//
//  SearchProgrammingLanguageUITests.swift
//  GithubRepoUITests
//
//  Created by Joyson P S on 07/06/21.
//

import XCTest

class SearchProgrammingLanguageUITests: XCTestCase {
    var app: XCUIApplication!
    var programmingLanguageTextField: XCUIElement!
    var searchButton: XCUIElement!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        self.searchButton = app.buttons["searchButton"]
        self.programmingLanguageTextField = app.textFields["programmingTextField"]

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }
    func testExample() throws {
        // UI tests must launch the application that they test.
 
        // Use recording to get started writing UI tests.
        
        let pragrammingLanguageTextField = app.textFields["pragramming language"]
        pragrammingLanguageTextField.tap()
        
        let searchStaticText = app.buttons["Search"]
        searchStaticText.tap()
        app.alerts["Error"].scrollViews.otherElements.buttons["Ok"].tap()
        pragrammingLanguageTextField.tap()
        searchStaticText.tap()
        app.navigationBars["c"].buttons["Back"].tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testEnterProgrammingNameVc_WhenLoaded_CheckUIElemetnsAreEnabled() throws {
        // UI tests must launch the application that they test.

        
        XCTAssertTrue(programmingLanguageTextField.isEnabled,"pragrammingLanguageTextField is disabled but it should have been enabled")
        
        XCTAssertTrue(searchButton.isEnabled,"searchButton is disabled but it should have been enabled")
      
    }
    func testEnterProgrammingNameVc_WhenProvidedInavalidInput_PresentErrorAlert() throws {
     
        searchButton.tap()
        XCTAssertTrue(app.alerts["Error"].exists,"Error alert dialog was not presented")
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testEnterProgrammingNameVc_WhenProvidedValidInput_PresentErrorAlert() throws {

        programmingLanguageTextField.tap()
        programmingLanguageTextField.typeText("swift")
        app.keyboards.buttons["Done"].tap()
        searchButton.forceTapElement()
        XCTAssertTrue(app.otherElements["RepoListViewController"].waitForExistence(timeout: 3),"The RepoListViewController was not presented when clicked on search with valid input.")

    }

}
