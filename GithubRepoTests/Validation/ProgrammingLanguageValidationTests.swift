//
//  ProgrammingLanguageValidationTests.swift
//  GithubRepoTests
//
//  Created by Joyson P S on 05/06/21.
//

import XCTest
@testable import GithubRepo

class ProgrammingLanguageValidationTests: XCTestCase {
    var sut: ProgrammingLanguageValidation!
    override class func setUp() {
        print("override class func setUp")

    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print(" override func setUpWithError() throws ")
        sut = ProgrammingLanguageValidation()


    }
    override class func tearDown() {
        print(" override class func tearDown")
        
    }

    override func tearDownWithError() throws {
        print("override func tearDownWithError() throws")
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testProgrammingLanguageValidator_WhenProvided_ShouldReturnTrue() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let isValid = sut.validate(langauge:"c")
        XCTAssertTrue(isValid.success,"isValid.sucess should have returned TRUE but returned FALSE")
        XCTAssertEqual(isValid.error, nil)

    }
    func testProgrammingLanguageValidator_WhenProvidedEmpty_ShouldReturnFalse() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let isValid = sut.validate(langauge:"")
        XCTAssertFalse(isValid.success,"isValid.sucess should have returned FALSE but returned TRUE")
        XCTAssertEqual(isValid.error, Constants.emptyLanguageError)
    }
    func testProgrammingLanguageValidator_WhenNotProvided_ShouldReturnFalse() throws {
        let isValid = sut.validate(langauge:nil)
        XCTAssertFalse(isValid.success,"isValid.sucess should have returned FALSE but returned TRUE")
        XCTAssertEqual(isValid.error, Constants.emptyLanguageError)

    }
  

}
