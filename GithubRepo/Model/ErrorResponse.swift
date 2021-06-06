//
//  ErrorResponse.swift
//  GithubRepo
//
//  Created by Joyson P S on 07/06/21.
//

import Foundation
struct ErrorResponse: Decodable {
    let documentation_url: URL?
    let errors: [CustomeError]?
    let message: String?
}

struct  CustomeError: Decodable {
    let code: String?
    let field: String?
    let message: String?
    let resource: String?
}
