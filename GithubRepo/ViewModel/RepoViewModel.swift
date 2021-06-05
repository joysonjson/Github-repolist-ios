//
//  RepoViewModel.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation

struct RepoViewModel {
    func getRepositories(langauge: String,page: Int, completion: @escaping(Result<Repositories?, ErrorMessage>)-> Void){
        let httpUtility = HttpRequest.shared
        guard let url = URL(string: EndPoints.baseUrl+EndPoints.searchRepositories) else { return }
        print("Calling pagination api",url)
        let queryParams:[String:Any] = ["q":"language:\(langauge)","sort":"stars","order":"desc","page":page]
        httpUtility.getApiData(requestUrl: url,resultType: Repositories.self,queryParams:queryParams) { (res) in
            completion(.success(res))
        } andFailure: { (error) in
            completion(.failure(.invalidData))
        }

    }
}
