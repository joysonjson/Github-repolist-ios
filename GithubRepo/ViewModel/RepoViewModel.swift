//
//  RepoViewModel.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation

struct RepoViewModel {
    /**
    APi call to fetch the api of reositories based on the query params
     - parameter langauge: Programming language wanted to search
     - parameter sort: String , want to sort based on
     - returns: Repositories, sucess or error for failure .

     # Notes: #
     1.  **sort** must be supported  by github cannot be random
     2. Handle return type because it is optional.
    */

    func getRepositories(langauge: String,sort: String,page: Int, completion: @escaping(Result<Repositories?, ErrorMessage>)-> Void){
        let httpUtility = HttpRequest.shared
        guard let url = URL(string: EndPoints.baseUrl+EndPoints.searchRepositories) else { return }
        let queryParams:[String:Any] = ["q":"language:\(langauge)","sort":sort,"order":"desc","page":page]
        httpUtility.getApiData(requestUrl: url,resultType: Repositories.self,queryParams:queryParams) { (res) in
            completion(.success(res))
        } andFailure: { (error) in
            completion(.failure(.invalidData))
        }

    }
}
