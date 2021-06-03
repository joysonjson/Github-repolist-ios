//
//  HttpCreateRequest.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
struct HttpCreateRequest {
    /**
     This Function Creates URL Request
     ```
     createRequest(httpMethod: .delete, url: URL, queryParams: [String:String], headers: [String:String], contentType: String)
     ```
     
     - Warning: Default there is no contentType, It is optional to provide default request to GET, al though for other request contentType is mandatory
     *** Body is not attached ***
     - Parameter httpMethod: HTTPMethod ( eg: .get, ,put, post etc.. )
     - Parameter url: URL
     - Parameter queryParams: [String:String]
     - Parameter headers: [String:String] , headers for the request eg: Authorization headers
     - Parameter contentType: String, eg: "applicaction/json"
     - Returns: URLRequest , with configured URL, header and query params
     */
    internal func createRequest(httpMethod:HTTPMethod,url:URL,queryParams: [String:String] = [:],headers:[String:String] = [:],contentType:String = "application/json") ->URLRequest{
        var request:URLRequest!
        var components = URLComponents(string: url.absoluteString)
        
        var absoluteUrl =  url
        for (key,val) in queryParams{
            absoluteUrl =  absoluteUrl.queryItems(key, value: val)
        }
        
        request = URLRequest(url: absoluteUrl)
        for (key,val) in headers {
            request.setValue(val, forHTTPHeaderField: key)
        }
     
        request.setValue(contentType, forHTTPHeaderField:"Content-Type")
        
        request.httpMethod = httpMethod.rawValue
        return request;
    }
}
