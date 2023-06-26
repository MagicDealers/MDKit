//
//  URLRequest+Additions.swift
//  MDKit
//
//  Created by Jorge Pardo on 27/01/2023.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

extension URLRequest {
    
    public init(host: String,
                path: String?,
                httpMethod: HTTPMethod,
                parameters: RequestParameters?,
                acceptedType: RequestAcceptType,
                headers: [String: String]?,
                cachePolicy: NSURLRequest.CachePolicy,
                timeoutInterval: TimeInterval) throws {
        
        let url = try URL(host: host, path: path)
        
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = timeoutInterval
        request.httpShouldHandleCookies = false
        
        try Self.appropriatelySetParameters(parameters, onRequest: &request)
        
        var allHeaders = (headers != nil) ? headers! : [String: String]()
        allHeaders["Accept"] = acceptedType.rawValue
        
        if case .body(_, let contentType) = parameters {
            allHeaders["Content-Type"] = contentType.rawValue
        }
        
        Self.setHeaders(allHeaders, onRequest: &request)
        
        self = request
    }
}

//MARK: - Private Methods.

extension URLRequest {
    
    private static func appropriatelySetParameters(_ parameters: RequestParameters?, onRequest request: inout URLRequest) throws {

        guard let parameters = parameters else {
            return
        }

        switch parameters {
        case .queryString(let dictionary):
            try encodeParameters(dictionary, forQueryStringOfRequest: &request)
            
        case .headers(let dictionary):
            setHeaders(dictionary, onRequest: &request)
            
        case .body(let any, let contentType):
            try encodeParameters(any, ofContentType: contentType, forBodyOfRequest: &request)
        }
    }
    
    private static func setHeaders(_ headers: [String: String], onRequest request: inout URLRequest) {
        
        headers.forEach {
            request.addValue($1, forHTTPHeaderField: $0)
        }
    }

    private static func encodeParameters(_ parameters: [String: Any], forQueryStringOfRequest request: inout URLRequest) throws {
        
        guard let url = request.url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        
        var allParameters = [String: Any]()
        urlComponents.queryItems?.forEach { allParameters[$0.name] = $0.value }
        parameters.forEach { allParameters[$0.key] = $0.value }
        
        urlComponents.percentEncodedQuery = queryString(from: allParameters)
        
        request.url = urlComponents.url
    }

    private static func encodeParameters(_ parameters: Any, ofContentType contenType: RequestContentType?, forBodyOfRequest request: inout URLRequest) throws {
        
        var data: Data?
        
        if case .json = contenType {
            data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
        } else if case .urlEncoded = contenType, let dictionary = parameters as? [String: Any] {
            
            let queryString = queryString(from: dictionary)
            data = Data(queryString.utf8)
        }
        
        request.httpBody = data
    }
    
    private static func queryString(from parameters: [String: Any]) -> String {
        
        var components = [(String, String)]()
        
        parameters.forEach {
            components += queryComponent(from: $0, value: $1)
        }
        
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    private static func queryComponent(from key: String, value: Any) -> [(String, String)] {
        
        var components = [(String, String)]()
        
        switch value {
            
        case let array as [Any]:
            fatalError("Logic to encode >> \(type(of: array)) << is not yet implemented.")

        case let dictionary as [String: Any]:
            fatalError("Logic to encode >> \(type(of: dictionary)) << is not yet implemented.")
            
        case let bool as Bool:
            fatalError("Logic to encode >> \(type(of: bool)) << is not yet implemented.")

        default:
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    private static func escape(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .rfc3986URLQueryAllowed) ?? string
    }
}

//MARK: - Helper Extensions.

extension CharacterSet {
    
    fileprivate static let rfc3986URLQueryAllowed: CharacterSet = {
        
        let reservedCharacterSet = CharacterSet.init(charactersIn: ":#[]@!$&'()*+,;=")
        return .urlQueryAllowed.subtracting(reservedCharacterSet)
    }()
}

//MARK: - Definitions.

public enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}

/**
 The media type (MIME type) used to identify the format in which the **request**  will send its contents.
 */

public enum RequestContentType: String {
    case json = "application/json"
    case urlEncoded = "application/x-www-form-urlencoded; charset=UTF-8"
}
 
/**
 The media type (MIME type) used to identify the format of the **response** accepted by the client.
 */

public enum RequestAcceptType: String {
   case json = "application/json"
   case urlEncoded = "application/x-www-form-urlencoded"
}

/**
 Defines the placement of the given parameters within the `URLRequest`.
 */

public enum RequestParameters {
    
    case queryString([String: Any])
    case headers([String: String])
    case body(Any, RequestContentType)
}
