//
//  UITestExtension.swift
//  GithubRepoUITests
//
//  Created by Joyson P S on 07/06/21.
//

import Foundation
import XCTest

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}
