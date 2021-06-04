//
//  RepoDetailsViewModel.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import Foundation
struct RepoDetailsViewModel {
    func getValue(type: DetailsToShowOptions,repo: Repository?)-> String{
        switch type {
        case .fullName:
            return repo?.full_name ?? ""
        case .description:
            return repo?.description ?? ""
        case .stars:
            return String(describing: repo?.stargazers_count ?? 0)
            
        case .forks:
            return String(describing: repo?.forks_count ?? 0)
        case .lastUpdated:
            return repo?.updated_at?.getDate() ?? ""
            
        }
        
    }
}
