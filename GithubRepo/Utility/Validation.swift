//
//  Validation.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation

struct ProgrammingLanguageValidation {

    func Validate(langauge: String?) -> ValidationResult
    {
        if(langauge?.isEmpty ?? true)
        {
            return ValidationResult(success: false, error: "Please enter language",value: nil)
        }
        return ValidationResult(success: true, error: nil,value: langauge!)
    }

}
