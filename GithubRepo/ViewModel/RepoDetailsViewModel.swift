//
//  RepoDetailsViewModel.swift
//  GithubRepo
//
//  Created by Joyson P S on 04/06/21.
//

import Foundation
struct RepoDetailsViewModel {
    /**
     This method returns the title and subtitle to repository details
     - parameter type: First Double Number.
     - parameter repo: Second Double Number.
     - parameter contributers: Contributers of the repo
     - parameter comments: top comments of the repo
     - parameter issues: top issues of the repo
     - parameter indexPath: IndexPath path for maping
     - returns: 2 strings with Title, subtile

     # Notes: #
     2. Handle return type because it is optional for attributed type.
    */

    func getValue(type: DetailsToShowOptions,repo: Repository?,contributers:[Contributer],comments:[Comment]?,issues:[Issue]?,indexPath:IndexPath)-> (String,String,NSAttributedString?){
        if (indexPath.section == 0){
            switch type {
            case .fullName:
                return (type.rawValue, repo?.full_name ?? "",nil)
            case .description:
                return (type.rawValue,repo?.description ?? "",nil)
            case .stars:
                return (type.rawValue,String(describing: repo?.stargazers_count ?? 0),nil)
            case .forks:
                return (type.rawValue,String(describing: repo?.forks_count ?? 0),nil)
            case .lastUpdated:
                return (type.rawValue,repo?.updated_at?.getDate() ?? "",nil)
                
            }
        }else if (indexPath.section == 1){
            let contributer = contributers[indexPath.row]
            return ("\(indexPath.row + 1). \(contributer.login ?? "-")","Contributions: \(contributer.contributions ?? 0)",nil)
            
        }else if (indexPath.section == 2){
            let issue = issues?[indexPath.row]
            return ( "\(indexPath.row + 1). \(issue?.title ?? "-")", issue?.body ?? "-",issue?.body?.getMarkdownContent())
        }else if (indexPath.section == 3){
            let comment = comments?[indexPath.row]
            return ("\(indexPath.row + 1). \(comment?.body ?? "")", "Careted at \(comment?.created_at?.getDate() ?? "-") by \(comment?.user?.login ?? "")",nil)
        
        }else{
            return ("","",nil)
        }
    }
    /**
     This method sum two double numbers and returns.

     Here is the discussion. This methods adds two double and return the optional Double.


     - parameter contributeUrl: First URL
     - parameter issueUrl: Second URL
     - parameter commentsUrl: third URL.

     - returns: (Bool,[Contributer],[Issue],[Comment])

     # Notes: #
     1. Disapth group make sure to leave all the block for sucess and failure
    */

    func getDetailsData(contributeUrl: String?,issueUrl: String?,commentsUrl:String?, completion: @escaping(Bool,[Contributer],[Issue],[Comment])-> Void){
        
        guard let contributerUrl = URL(string:  contributeUrl ?? ""), let issueUrl = URL(string: issueUrl?.correctUrl() ?? ""), let commentsUrl = URL(string: commentsUrl?.correctUrl() ?? "") else {
            return
        }
        let group = DispatchGroup()
        var contributors:[Contributer] = []
        var comments:[Comment] = []
        var issues:[Issue] = []
        
        let qPrams:[String:Any] = ["per_page":3]
        let httpUtility = HttpRequest.shared
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
            completion(true,contributors,issues,comments)
        }
    }
}
