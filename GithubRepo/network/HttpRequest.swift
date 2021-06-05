//
//  HttpRequest.swift
//  GithubRepo
//
//  Created by Joyson P S on 03/06/21.
//

import Foundation



struct HttpRequest{
    let service = NetworkSession()
    let createRequest = HttpCreateRequest()
    public typealias queryParams = [String:Any]
    public var headers: [String:Any] = [:]
    

    public static var shared = HttpRequest()
    
    private init(){
        
    }

    /**
     GET Api call
     - Warning: Returns either sucess or failure
     - Parameter url: URL
     - Parameter completionHandler: (_ status: Bool,_ result: T?,_ error: String?),
     - Parameter Status: Bool indicating sucess of failed
     - Parameter result: Decoding to a matching madel class
     - Parameter error: error in a string format
     */

    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, queryParams:queryParams = [:],withSuccess successBlock:@escaping (_ object:T?)->Void,andFailure failureBlock: @escaping (_ error: String)->Void){
        let req = createRequest.createRequest(httpMethod: .get, url: requestUrl, queryParams: queryParams, headers: headers)
        service.call(with: req) { (response,repsonseData,error ) in
            let (staus,err,res) = self.reponseParser(response: response, responseData: repsonseData, error: error, resultType: T.self)
            if (staus){
                successBlock(res)
            }else{
                failureBlock(err ?? "")
            }
            
        }
    }
}


extension HttpRequest{
    /**
     - Parameter response: URLResponse?
     - Parameter responseData: Data?
     - Parameter error: Error?
     - Parameter resultType: Decodable
     - Returns: Bool, true or false status of the request.
     - Returns: Bool, true or false status of the request.
     - Returns: T, Decodable object
     */
    private func reponseParser<T:Decodable>(response: URLResponse?,responseData: Data?,error: Error?,resultType:T.Type )-> (Bool,String?,T?){
        let httpResponse = response as! HTTPURLResponse
        if 200...300 ~= httpResponse.statusCode , let data = responseData{
            let res = try? JSONDecoder().decode(T.self, from: data)
            if let obj = res{
                return (true,error?.localizedDescription,obj)
            }
            return (true,error?.localizedDescription,nil)

        }else{
            return (false,error?.localizedDescription,nil)
        }
    }
}
