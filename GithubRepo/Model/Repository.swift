//
//  Repository.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
struct Repositories: Decodable {
    let incomplete_results: Bool?
    let total_count: Int?
    let items:[Repository]?
}
struct Repository: Decodable {
    let id:Int?
    let name:String?
    let full_name:String?
    let owner:Contributer?
    let description:String?
    let url:URL?
    let collaborators_url:String?
    let teams_url:URL?
    let contributors_url:URL?
//
    let comments_url:String?
    let issue_comment_url:String?
    let created_at:String?
    let updated_at:String?
    let pushed_at:String?
    let homepage:String?
    let stargazers_count:Int?
    let watchers_count:Int?
    let issues_url: String?
    let language:String?
    let forks_count:Int?
    let open_issues_count:Int?
    let forks:Int?
    let open_issues:Int?
    let watchers:Int?
}

struct Contributer: Decodable {
    let login: String?
    let id:Int?
    let node_id:String?
    let avatar_url:URL?
    let gravatar_id:String?
    let url:URL?
    let html_url: URL?
    let contributions:Int?
}
