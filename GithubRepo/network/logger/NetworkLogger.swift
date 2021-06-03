//
//  NetworkLogger.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
/**
 Logger class the prints or writes the all the request to a file. Based on the log levels.
 
 */

class NetworkingLogger {
    
    public var logLevels : NetworkingLogLevel = .debug
    /**
     Logs the request to console
     ```
     log(request: URLRequest())
     
     ```
     - Parameter request: URLRequest
     - Returns: None
     */
    
    func log(request: URLRequest?) {
        guard logLevels != .off , let req = request else {
            return
        }
        if let verb = req.httpMethod,
            let url = req.url {
            print("\(verb) '\(url.absoluteString)'")
            logHeaders(req)
            logBody(req)
        }
    }
    /**
     Logs the URLResponse and  Data
     ```
     log(response: URLResponse?, data: Data?)
     
     ```
     - Parameter response: URLResponse? , Optional
     - Parameter data: Data? , Optional
     - Returns: None
     */
    
    func log(response: URLResponse?, data: Data?) {
        guard logLevels != .off else {
            return
        }
        if let response = response as? HTTPURLResponse {
            logStatusCodeAndURL(response)
        }
        if logLevels == .debug, let responseData = data {
            if let json = try? JSONSerialization.jsonObject(with: responseData, options: []) {
                print(json)
            }
        }
    }
    /**
     Logs the Header of a request
     ```
     logHeaders(req)
     
     ```
     - Parameter urlRequest: URLRequest
     - Returns: None
     */
    private func logHeaders(_ urlRequest: URLRequest) {
        if let allHTTPHeaderFields = urlRequest.allHTTPHeaderFields {
            for (key, value) in allHTTPHeaderFields {
                print("  \(key) : \(value)")
            }
        }
    }
    /**
    Logs the Body of a request
    ```
    logBody(req)
    
    ```
    - Parameter urlRequest: URLRequest
    - Returns: None
    */
    private func logBody(_ urlRequest: URLRequest) {
        if let body = urlRequest.httpBody,
            let str = String(data: body, encoding: .utf8) {
            print("  HttpBody : \(str)")
        }
    }
    /**
      Logs the response Status Code and Url of the HTTPURLResponse
      - Parameter urlResponse: HTTPURLResponse
      - Returns: None
      */
    private func logStatusCodeAndURL(_ urlResponse: HTTPURLResponse) {
        if let url = urlResponse.url {
            print("\(urlResponse.statusCode) '\(url.absoluteString)'")
        }
    }
}
