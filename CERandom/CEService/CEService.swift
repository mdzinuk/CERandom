//
//  CEService.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit

class CEService: CEServiceProtocol {
    func fetchPeople(for params: CEStringDictionary,
                     completion: @escaping(CEServiceReply<Random, CEError>) -> Void) {
        CENetworkManager
            .shared()
            .dataTask(for: params) { (result: CEServiceReply<Data, CEError>) in
                switch result {
                case .failure(let error):
                    completion(CEServiceReply.failure(error))
                case .success(let data):
                    guard let list = CECodable<Random>.decode(from: data) else {
                        completion(CEServiceReply.failure(CEError.decoding))
                        return
                    }
                    CECoreDataManager.shared().deleteRecords()
                    CECoreDataManager.shared().storeRecords(list)
                    completion(CEServiceReply.success(list))
                }
        }
    }
    func downloadImage(for url: String,
                       completion: @escaping (CEServiceReply<UIImage, CEError>) -> Void) {
        CENetworkManager
            .shared()
            .dataTask(from: url) { (result: CEServiceReply<Data, CEError>) in
                switch result {
                case .failure(let error):
                    completion(CEServiceReply.failure(error))
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        completion(CEServiceReply.failure(CEError.decoding))
                        return
                    }
                    completion(CEServiceReply.success(image))
                }
        }
    }
    func fetchPeopleFromCoreData(completion: @escaping(CEServiceReply<[Random.Person], CEError>) -> Void) {
        DispatchQueue.main.async {
            CECoreDataManager
                .shared()
                .retrieve { (coreData: CEServiceReply<[Random.Person], CEError>) in
                    switch coreData {
                    case .success(let list):
                        completion(CEServiceReply.success(list))
                    case .failure(let error):
                        completion(CEServiceReply.failure(error))
                    }
            }
        }
    }
}

