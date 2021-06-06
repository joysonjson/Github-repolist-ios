//
//  ProgrammingLanguageValidationTests.swift
//  GithubRepoTests
//
//  Created by Joyson P S on 05/06/21.
//

import XCTest
@testable import GithubRepo

class ProgrammingLanguageValidationTests: XCTestCase {
    
    override class func setUp() {
        print("override class func setUp")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print(" override func setUpWithError() throws ")

    }
    override class func tearDown() {
        print(" override class func tearDown")
    }

    override func tearDownWithError() throws {
        print("override func tearDownWithError() throws")

        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testProgrammingLanguageValidator_WhenProvided_ShouldReturnTrue() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let res = ProgrammingLanguageValidation()
        let isValid = res.validate(langauge:"c")
        XCTAssertTrue(isValid.success,"isValid.sucess should have returned TRUE but returned FALSE")
    }
    func testProgrammingLanguageValidator_WhenProvidedEmpty_ShouldReturnFalse() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let res = ProgrammingLanguageValidation()
        let isValid = res.validate(langauge:"")
        XCTAssertFalse(isValid.success,"isValid.sucess should have returned FALSE but returned TRUE")
    }
    func testProgrammingLanguageValidator_WhenNotProvided_ShouldReturnFalse() throws {
        let res = ProgrammingLanguageValidation()
        let isValid = res.validate(langauge:nil)
        XCTAssertFalse(isValid.success,"isValid.sucess should have returned FALSE but returned TRUE")
    }
  

}
