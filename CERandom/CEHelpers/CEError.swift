//
//  CEError.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import Foundation

public enum CEError: Error {
    case network
    case url
    case decoding
    case coredata
    
    var localizedDescription: String {
        switch self {
        case .network:
            return "No internet connection"
        case .decoding:
            return "CECodable serialized error"
        case .coredata:
            return "Coredata error"
        case .url:
            return "Url is broken"
        }
    }
}
