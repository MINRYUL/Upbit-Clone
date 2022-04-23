//
//  HTTPRequest.swift
//  Upbit-Clone
//
//  Created by 김민창 on 2022/04/23.
//

import Foundation

protocol Request {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var httpMethod: HTTPMethodType? { get }
}

public enum HTTPMethodType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public struct DefaultRequest: Request {
    public let baseURL: URL
    public let headers: [String: String]
    public let httpMethod: HTTPMethodType?
    
     public init(baseURL: URL,
                 headers: [String: String] = [:],
                 httpMethod: HTTPMethodType? = nil) {
        self.baseURL = baseURL
        self.headers = headers
        self.httpMethod = httpMethod
    }
    
    var request: URLRequest {
        var urlRequest = URLRequest(url: self.baseURL)
        self.headers.forEach({ header in
            urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
        })
        
        guard let httpMethod = self.httpMethod else { return urlRequest }
        
        urlRequest.httpMethod = httpMethod.rawValue
        return urlRequest
    }
}
