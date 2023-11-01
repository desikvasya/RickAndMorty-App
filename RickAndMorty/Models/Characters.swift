//
//  Characters.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import Foundation

struct Characters: Codable {
    let name: String
    let image: String
}

// MARK: - BaseInfo
struct BaseInfo: Decodable {
    let info: Info
    let results: [DetailsCharacter]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}

// MARK: - Result
struct DetailsCharacter: Decodable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Decodable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        if let gender = Gender(rawValue: rawValue) {
            self = gender
        } else {
            self = .unknown
        }
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}


enum Species: Codable {
    case humanoid(String)
    case unknown(String)
    case alien(String)
    case human(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        switch rawValue.lowercased() {
        case "humanoid":
            self = .humanoid(rawValue)
        case "alien":
            self = .alien(rawValue)
        case "human":
            self = .human(rawValue)
        default:
            self = .unknown(rawValue)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawStringValue)
    }
    
    private var rawStringValue: String {
        switch self {
        case .humanoid(let value), .alien(let value), .human(let value), .unknown(let value):
            return value
        }
    }
}
enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
