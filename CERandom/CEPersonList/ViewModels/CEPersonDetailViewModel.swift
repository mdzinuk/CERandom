//
//  CEPersonDetailViewModel.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import UIKit

final class CEPersonDetailViewModel: CEPersonDetailViewModelProtocol {
    init() { }
    func getLargeImage(from link: String, completion: @escaping (UIImage?) -> Void) {
        CEService().downloadImage(for: link, completion: { (result: CEServiceReply<UIImage, CEError>) in
            switch result {
            case .failure( _):
                completion(.none)
            case .success(let image):
                completion(image)
            }
        })
    }
}
