//
//  CECodable.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import Foundation

// MARK: CECodable
struct CECodable<T: Codable>: Codable {
    static func decode(from data: Any?) -> T? {
        guard let data = data as? Data else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let tType = try? decoder.extraDecode(T.self, for: data) else {
            return nil
        }
        return tType
    }
    static func encode(for type: T?) -> [String: Any] {
        guard let data = try? JSONEncoder().encode(type),
            let dict = try? JSONSerialization.jsonObject(with: data,
                                                         options: .allowFragments) as? [String: Any] else {
                                                            return [:]
        }
        return dict
    }
}

// MARK: JSONDecoder extension
fileprivate extension JSONDecoder {
    func extraDecode<T: Codable>(_ type: T.Type, for data: Data) throws -> T {
        dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            if let date = DateFormatter.isoDate(dateStr) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container,
                                                   debugDescription: "\(CEError.decoding.localizedDescription) for \(dateStr) string")
        })
        return try decode(type, from: data)
    }
}
