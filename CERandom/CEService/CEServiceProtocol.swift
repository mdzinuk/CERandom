//
//  CEServiceProtocol.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit

protocol CEServiceProtocol: class {
    func fetchPeople(for params: CEStringDictionary,
                     completion: @escaping(CEServiceReply<Random, CEError>) -> Void)
    func downloadImage(for url: String,
                       completion: @escaping (CEServiceReply<UIImage, CEError>) -> Void)
    func fetchPeopleFromCoreData(completion: @escaping(CEServiceReply<[Random.Person], CEError>) -> Void)
}
