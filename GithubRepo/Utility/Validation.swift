//
//  Validation.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation

struct ProgrammingLanguageValidation {
    /**
     This method checks the whether enterd string is valida or not.

     - parameter langauge: Programming langauge name.
     - parameter number2: Second Double Number.
     - returns: ValidationResult, with sucess or error and value.

     # Notes: #
     1. Parameters must be **String** type
     2. Handle return type because it is optional.

     # Example #
    ```
     let result = ProgrammingLanguageValidation().Validate(langauge: "swift") 
     ```
    */

    func Validate(langauge: String?) -> ValidationResult
    {
        if(langauge?.isEmpty ?? true)
        {
            return ValidationResult(success: false, error: "Please enter language",value: nil)
        }
        return ValidationResult(success: true, error: nil,value: langauge!)
    }

}
