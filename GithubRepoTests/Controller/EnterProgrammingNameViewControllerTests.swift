//
//  EnterProgrammingNameViewControllerTests.swift
//  GithubRepoTests
//
//  Created by Joyson P S on 07/06/21.
//

import XCTest
@testable import GithubRepo

class EnterProgrammingNameViewControllerTests: XCTestCase {
    var storyboard: UIStoryboard!
    var vc: EnterProgrammingNameViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(identifier: "EnterProgrammingNameViewController") as! EnterProgrammingNameViewController
        vc.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testEnterProgrammingNameViewController_WhenCreated_HasEmptyLangauageTextField() throws{
        let languageTextField = try XCTUnwrap(vc.programNameTextField, "Program name textfield is not connected to a IB outlet")
        XCTAssertEqual(languageTextField.text, "", "The default value should be empty but it is not")
    }

    func testEnterProgrammingNameViewController_WhenCreated_HasSearchButton() throws{
        let searchButton: UIButton = try XCTUnwrap(vc.searchButton, "EnterProgrammingNameViewController Does not has a outlet connected with IBOutlet.")
        let signUpButtonAction = searchButton.actions(forTarget: vc, forControlEvent: .touchUpInside)
        XCTAssertEqual(signUpButtonAction?.count, 1)
        XCTAssertEqual(signUpButtonAction!.first, "searchAction:","There is no searchAction to searchButton")
    }
}
