//
//  APIConfiguration.swift
//  NetworkLayer
//
//  Created by Sabbir Hossain on 21/9/23.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
