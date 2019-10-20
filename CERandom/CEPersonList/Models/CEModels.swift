//
//  CEModels.swift
//  CERandom
//
//  Created by Mohammad Arafat Hossain on 20/10/19.
//  Copyright © 2019 Mohammad Arafat Hossain. All rights reserved.
//

import Foundation

struct Random: Codable {
    let persons: [Person]
    let page: Page
    
    enum CodingKeys:String,CodingKey {
        case page = "info"
        case persons = "results"
    }
    struct Person: Codable {
        let gender: String?
        let nat: String?
        let email: String?
        let name: Name
        let dob: Dob
        let picture: Picture
        
        struct Dob: Codable {
            let date: Date
            let age: Double
        }
        struct Name: Codable {
            let title, first, last: String
        }
        struct Picture: Codable {
            let large, thumbnail: String
        }
    }
    struct Page: Codable {
        let items, number: Int
        enum CodingKeys:String,CodingKey {
            case items = "results"
            case number = "page"
        }
    }
}

protocol PersonInfo {
    var fullName: String { get }
    var birthday: String { get }
    var contact: String { get }
    var pictureLink: String { get }
}
extension Random.Person: PersonInfo {
    var fullName: String {
        return "Name: \(name.title). \(name.first) \(name.last)"
    }
    var birthday: String {
        return "Born in: \(DateFormatter.toString(dob.date))"
    }
    var contact: String {
        return "Email: \(email ?? "") \nGender: \(gender ?? "") \nNationality: \(nat ?? "")"
    }
    var pictureLink: String {
        return picture.large
    }
}
