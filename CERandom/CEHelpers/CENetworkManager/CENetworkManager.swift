//
//  CENetworkManager.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import Foundation

public class CENetworkManager {
    private static let baseURL: URL = URL(string: "https://randomuser.me")!
    private let session: URLSession
    private static var sharedManager: CENetworkManager = {
        let manager = CENetworkManager()
        return manager
    }()
    
    init(_ session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public class func shared() -> CENetworkManager {
        return sharedManager
    }
    public func dataTask(for params: CEStringDictionary,
                         completion: @escaping(CENetworkResponseData) -> Void) {
        let urlRequest = URLRequest(url: CENetworkManager.baseURL.appendingPathComponent("api"))
        let encodedRequest = urlRequest.encode(with: params)
        
        session.dataTask(with: encodedRequest,
                         completionHandler: { data, response, error in
                            guard let httpResponse = response as? HTTPURLResponse,
                                httpResponse.hasSuccessCode,
                                let data = data else {
                                    completion(CEServiceReply.failure(CEError.network))
                                    return
                            }
                            completion(CEServiceReply.success(data))
        }).resume()
    }
    public func dataTask(from urlSting: String,
                         completion: @escaping (CENetworkResponseData) -> Void) {
        guard let url = URL(string:urlSting) as URL? else {
            completion(CEServiceReply.failure(CEError.url))
            return
        }
        
        session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessCode,
                let data = data else {
                    completion(CEServiceReply.failure(CEError.network))
                    return
            }
            completion(CEServiceReply.success(data))
        }).resume()
    }
}


