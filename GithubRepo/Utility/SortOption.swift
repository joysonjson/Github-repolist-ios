//
//  SortOption.swift
//  GithubRepo
//
//  Created by Joyson P S on 05/06/21.
//

import Foundation
/**
Sorting option available for repositories
*/
enum SortOption: String ,CaseIterable{
    case stars = "stars"
    case forks = "forks"
    case lastUpdated = "updated"
    
}
