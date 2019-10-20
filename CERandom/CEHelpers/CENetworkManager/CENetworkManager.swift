//
//  CENetworkManager.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import Foundation

public class CENetworkManager {
    private static var sharedManager: CENetworkManager = {
        let manager = CENetworkManager()
        return manager
    }()
    
    public class func shared() -> CENetworkManager {
        return sharedManager
    }
    
    private static let baseURL: URL = URL(string: "https://randomuser.me")!
    private let session: URLSession
    
    init(_ session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func dataTask(for params: CENetworkParam, completion: @escaping(CENetworkResponseData) -> Void) {
        let urlRequest = URLRequest(url: CENetworkManager.baseURL.appendingPathComponent("api"))
        let encodedURLRequest = urlRequest.encode(with: params)
        
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessCode, let data = data else {
                completion(CEServiceReply.failure(CEError.network))
                return
            }
            completion(CEServiceReply.success(data))
        }).resume()
    }
    
    public func dataTask(from urlSting: String, completion: @escaping (CENetworkResponseData) -> Void) {
        guard let url = URL(string:urlSting) as URL? else {
            completion(CEServiceReply.failure(CEError.url))
            return
        }
        
        session.dataTask(with: url, completionHandler: {
            (data, response, error) -> Void in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.hasSuccessCode, let data = data else {
                completion(CEServiceReply.failure(CEError.network))
                return
            }
            completion(CEServiceReply.success(data))
        }).resume()
    }
}


