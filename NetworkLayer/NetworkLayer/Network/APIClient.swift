//
//  APIClient.swift
//  NetworkLayer
//
//  Created by Sabbir Hossain on 21/9/23.
//

import Foundation
import Alamofire

class APIClient {
    
    static func login(email: String, password: String, completion:@escaping (Result<User, AFError>)->Void) {
        AF.request(UserEndpoint.login(email: email, password: password))
                 .responseDecodable { (response: DataResponse<User, AFError>) in
                     completion(response.result)
        }
    }
    
    static func getArticles(completion:@escaping (Result<[Article], AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.articleDateFormatter)
        AF.request(UserEndpoint.articles).responseDecodable(decoder: jsonDecoder) { (response: DataResponse<[Article], AFError>) in
            completion(response.result)
        }
    }
}
