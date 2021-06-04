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
    func getDetailsData(contributeUrl: String?,issueUrl: String?,commentsUrl:String?, completion: @escaping(Bool,[Contributer],[Issue],[Comment])-> Void){
        
        guard let contributerUrl = URL(string:  contributeUrl ?? ""), let issueUrl = URL(string: issueUrl?.correctUrl() ?? ""), let commentsUrl = URL(string: commentsUrl?.correctUrl() ?? "") else {
            return
        }
        let group = DispatchGroup()
        var contributors:[Contributer] = []
        var comments:[Comment] = []
        var issues:[Issue] = []
        
        let qPrams:[String:Any] = ["per_page":3]

        let httpUtility = HttpRequest()
        group.enter()
        
        httpUtility.getApiData(requestUrl: contributerUrl,resultType: [Contributer].self,queryParams: qPrams) { (res) in
            contributors = res ?? []
            group.leave()
            
        } andFailure: { (error) in
            group.leave()
        }
        group.enter()

        httpUtility.getApiData(requestUrl: issueUrl,resultType: [Issue].self,queryParams: qPrams) { (res) in
            issues = res ?? []
            group.leave()
            
            
        } andFailure: { (error) in
            group.leave()
        }
        group.enter()

        httpUtility.getApiData(requestUrl: commentsUrl,resultType: [Comment].self,queryParams: qPrams) { (res) in
            comments = res ?? []
            group.leave()
            
        } andFailure: { (error) in
            group.leave()
        }
        group.notify(queue: .main){
            print("Finished")
            completion(true,contributors,issues,comments)
        }
        
        
    }
}
