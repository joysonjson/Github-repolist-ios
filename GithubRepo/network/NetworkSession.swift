//
//  NetworkSession.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation
struct NetworkSession {
    private let logger: NetworkingLogger = NetworkingLogger()
    typealias ServiceSuccessBlock = (_ dataTask:URLResponse?, _ response: Data?,_ error: Error?) -> Void

    /**
         This Function establishes a session for a request
      ```
     NetworkSession().call(with request:URLRequest, withSuccess servicesBlock:@escaping ((_ dataTask:URLResponse, _ response: Data?,_ error: Error?)))
      ```
      - Warning: No error handling, just return the data, response and the error object
      - Parameter request: URLRequest( POST, GET, PATCH , etc... )
      - Parameter servicesBlock: Completion Handler
      */
    func call(with request:URLRequest, withSuccess servicesBlock:@escaping (ServiceSuccessBlock)) {
       
        let dataTask = URLSession.shared.dataTask(with: request) {
            data,response,error in
            self.logger.log(request: request)
            self.logger.log(response: response, data: data)
            servicesBlock(response ?? URLResponse(),data,error)
           
        }
        dataTask.resume()
        
    }
}

