//
//  APIRouter.swift
//  NetworkLayer
//
//  Created by Sabbir Hossain on 21/9/23.
//

import Foundation
import Alamofire

enum UserEndpoint: APIConfiguration {
    
    case login(email: String, password: String)
    case articles
    case article(id: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .articles, .article:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .articles:
            return "/articles/all.json"
        case .article(let id):
            return "/article/\(id)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
        case .articles, .article:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
