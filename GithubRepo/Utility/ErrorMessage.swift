//
//  ErrorMessage.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
/**
 ErrorMessage, standard enum for handling error
*/
enum ErrorMessage: String, Error {
    case invalidData = "Sorry. Somthing went wrong, try again"
    case invalidResponse = "Server error. Please modify your search and try again"
}
