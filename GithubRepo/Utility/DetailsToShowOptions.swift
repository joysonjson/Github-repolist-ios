//
//  DetailsToShowOptions.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import Foundation
/**
 DetailsToShowOptions enum shows details of a repo in details screen dynamically

*/
enum DetailsToShowOptions:String, CaseIterable  {
    case fullName = "Full Name"
    case description = "Description"
    case stars = "Stars"
    case forks = "Forks"
    case lastUpdated = "Last Updated"
}
