//
//  CENetworkManager+Extension.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import Foundation

public typealias CEStringDictionary = [String: String]
public typealias CENetworkResponseData = (CEServiceReply<Data, CEError>)

// MARK: CEServiceReply Value type
public enum CEServiceReply<T, U> {
    case success(T)
    case failure(U)
}

// MARK: URLRequest extension
extension URLRequest {
    func encode(with parameters: CEStringDictionary?) -> URLRequest {
        guard let parameters = parameters else {
            return self
        }
        
        var encodeRequest = self
        if let url = url, let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            !parameters.isEmpty {
            var newUrlComponents = urlComponents
            let queryItems = parameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
            newUrlComponents.queryItems = queryItems
            encodeRequest.url = newUrlComponents.url
            return encodeRequest
        } else {
            return self
        }
    }
}

// MARK: HTTPURLResponse extension
extension HTTPURLResponse {
    var hasSuccessCode: Bool {
        return 200...299 ~= statusCode
    }
}
