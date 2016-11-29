//
//  APIRouter.swift
//  LearnSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 28/11/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//


import UIKit

import Alamofire

let baseURLStr = "https://omgvamp-hearthstone-v1.p.mashape.com"

public typealias JSONDictionary = [String : Any]
public typealias APIParameters = [String : Any]?



protocol APIConfigurable {
    var method: Alamofire.HTTPMethod { get }
    var headers: Alamofire.HTTPHeaders { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParameters { get }
    var baseURL: String { get }
    
}

enum Endpoint {
    
    case getCards()
}

class BaseRouter: URLRequestConvertible, APIConfigurable {
    
    init() {
        
    }
    
    var method: Alamofire.HTTPMethod {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }
    
    var headers: Alamofire.HTTPHeaders {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }
    
    var encoding: Alamofire.ParameterEncoding? {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }
    
    var path: String {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }
    
    var parameters: APIParameters {
        fatalError("[\(Mirror(reflecting: self).description) - \(#function))] Must be overridden in subclass")
    }
    
    var baseURL: String {
        return baseURLStr
    }
    
    
    
    func asURLRequest() throws -> URLRequest {
        
        let baseURL = try self.baseURL.asURL()
        let endpoint = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: endpoint)
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("xd90O4gfMdmshyLxk5cBvl44PPHlp1ONA3kjsnFFOAtbQnoshp", forHTTPHeaderField: "X-Mashape-Key")
        
        if let encoding = encoding {
            
            if let extendedParameters = parameters {
                
                let request = try encoding.encode(urlRequest, with: extendedParameters)
                return request
                
            } else {
                let request = try encoding.encode(urlRequest, with: parameters)
                return request
            }
        }
        
        return urlRequest
    }
}



class APIRouter: BaseRouter {
    
    var endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    
    override var method: Alamofire.HTTPMethod {
        
        switch endpoint {
        case .getCards: return .get
            
        }
    }
    
    override var headers: Alamofire.HTTPHeaders {
        
        switch endpoint {
            
        case .getCards:
            
            let headerValue: [String: String] = ["X-Mashape-Key" : "xd90O4gfMdmshyLxk5cBvl44PPHlp1ONA3kjsnFFOAtbQnoshp"]
            return headerValue
        }
    }
    
    override var path: String {
        
        switch endpoint {
            
        case .getCards(): return "/cards"
            
        }
    }
    
    override var parameters: APIParameters {
        
        return nil
    }
    
    override var encoding: Alamofire.ParameterEncoding? {
        switch endpoint {
            
        case .getCards(): return JSONEncoding.default
            
        }
    }
}

