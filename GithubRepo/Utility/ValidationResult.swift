//
//  ValidationResult.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation

/**
 ValidationResult , generic enum for validation
 */

struct ValidationResult
{
    let success: Bool
    let error : String?
    let value : String?
}
