//
//  APIManager.swift
//  LearnSwift3
//
//  Created by Vijayalakshmi Pulivarthi on 28/11/16.
//  Copyright © 2016 sourcebits. All rights reserved.
//

import UIKit
import Alamofire

/// API error related constants

public enum APIErrorConstants {
    static let domain = "com.inflooense.errorDomain"
}


/// Enum wrapping all errors in an Error type specific to your app

enum BackendError: Error {
    case network(error: Error)                  // Capture any underlying Error from the URLSession API
    case dataSerialization(reason: String)
    case jsonSerialization(error: Error)
    case serverApplication(error: NSError)
    case realm(error: NSError)
    case objectSerialization(reason: String)
    case sessionValidation(reason: String)
    
    func logDescription() -> String {
        
        var targetDescription: String
        
        switch self {
            
        case .sessionValidation(let reason):
            targetDescription = "BackendError.sessionValidation: \(reason)"
        case .objectSerialization(let reason):
            targetDescription = "BackendError.objectSerialization: \(reason)"
        case .network(let underlyingError as AFError):
            targetDescription = "BackendError.network AF: \(underlyingError.errorDescription)"
        case .network(let underlyingError):
            targetDescription = "BackendError.network: \(underlyingError.localizedDescription)"
        case .jsonSerialization(let underlyingError):
            targetDescription = "BackendError.jsonSerialization: \(underlyingError.localizedDescription)"
        case.serverApplication(let underlyingError):
            targetDescription = "BackendError.serverApplication - \(underlyingError.code): \(underlyingError.localizedDescription)"
        case .dataSerialization(let reason):
            targetDescription = "BackendError.dataSerialization: \(reason)"
        case .realm(let error):
            targetDescription = "Realm: \(error.description)"
        }
        
        return targetDescription
    }
}




class APIManager {
    
    static let shared = APIManager()
    static let serverTrustPolicies: [String: ServerTrustPolicy] = [
        "54.201.70.52": .disableEvaluation,
        ]
    
    var internalManager: SessionManager!
    let reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    
    fileprivate init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        
        // Init the Alamofire manager
        internalManager = SessionManager(configuration: configuration,
                                         serverTrustPolicyManager: ServerTrustPolicyManager(policies: APIManager.serverTrustPolicies))
    }
}

// MARK: - Validation Methods

extension APIManager {
    
    func validate(response urlResponse: HTTPURLResponse, data: Data?) -> Request.ValidationResult {
        
        if 200 ... 299 ~= urlResponse.statusCode {
            
            // Check if the application server response is valid
            if let data = data {
                
                do {
                    if  let responseDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONDictionary,
                        let _ = responseDictionary["response"] {
                        
                        return .success
                        
                    } else {
                        return .failure(BackendError.objectSerialization(reason: "Unexpected response format"))
                    }
                    
                } catch let error {
                    return .failure(BackendError.jsonSerialization(error: error))
                }
            } else {
                return .failure(BackendError.dataSerialization(reason: "Missing response data"))
            }
            
        } else {
            return .failure(BackendError.network(error: NSError(domain: APIErrorConstants.domain, code: urlResponse.statusCode, userInfo: nil)))
        }
    }
}

// MARK: - Authentication Methods

extension APIManager{
    
    //MARK: - GetCards
    func cardsInformation(callBack: @escaping (NSDictionary?, NSError?) -> (Void)) {
        
        let router = APIRouter(endpoint: .getCards())
        
        internalManager.request(router)
            .responseJSON { (response) in
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    callBack(JSON,nil)
                }
                if let error = response.result.error {
                    callBack(nil, error as NSError)
                }
        }
    }
    
}



