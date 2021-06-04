//
//  RepoViewModel.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation

struct RepoViewModel {
    func getRepositories(langauge: String, completion: @escaping(Result<[Repository], ErrorMessage>)-> Void){
        let httpUtility = HttpRequest()
        guard let url = URL(string: EndPoints.baseUrl+EndPoints.searchRepositories) else { return }
        let queryParams = ["q":"language:\(langauge)","sort":"stars","order":"desc"]
        httpUtility.getApiData(requestUrl: url,resultType: Repositories.self,queryParams:queryParams) { (res) in
            completion(.success(res?.items ?? []))
        } andFailure: { (error) in
            completion(.failure(.invalidData))
        }

    }
}
