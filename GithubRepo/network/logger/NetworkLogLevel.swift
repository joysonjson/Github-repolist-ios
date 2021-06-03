//
//  NetworkLogLevel.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
/**
 Loglevels
 off mode is kept to avoid wrting or printing in the production build
 */

public enum NetworkingLogLevel {
    case off
    case info
    case debug
}
