//
//  Issue.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import Foundation

struct Issue: Decodable {
    
    let url: URL?
    let html_url: URL?
    let id: Int?
    let created_at: String?
    let updated_at: String?
    let body: String?
    let title: String?
    let locked:Bool?
    let user: Contributer?

}
