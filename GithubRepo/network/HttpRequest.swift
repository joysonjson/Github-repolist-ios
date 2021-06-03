//
//  HttpRequest.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation

struct HttpRequest
{
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ status: Bool,_ result: T?,_ error: String?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil)
            {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    completionHandler(true, result, nil)
                }
                catch let error{
                    debugPrint("error occured while decoding = \(error)")
                    completionHandler(false, nil, "Falied to map the data")
                }
            }else{
                completionHandler(false, nil, error?.localizedDescription)
            }

        }.resume()
    }
}
