//
//  Match.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 19/12/23.
//

import Foundation

struct Game: Decodable {
    let matchDetails: MatchDetail
    let teams: Team
}


extension Game {
    struct MatchDetail: Decodable {
        let teamHome: Int
        let teamAway: Int
        let match: Match
        let series : Series
        let venue: Venue
        let status: String
        let result: String
    }
    
    struct Match: Decodable {
        let id: Int
        let date: String
        let time: String
    }
    
    struct Series: Decodable {
        let id: Int
        let name: String
        let status: String
        let tourName: String
    }
    
    struct Venue: Decodable {
        let id: Int
        let name: String
    }
    
    struct Team: Decodable {
        let teams: [String: String]
    }
}

extension Game.Team {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyKey.self)
        let keys = container.allKeys
        var result = [String: String](minimumCapacity: keys.count)
        for key in keys {
            result[key.stringValue] = try container.decode(String.self, forKey: key)
        }
        self.teams = result
    }
}

struct AnyKey: CodingKey {
    enum Errors: Error {
        case invalid
    }
    
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        stringValue = "\(intValue)"
    }
    
    static func key(named name: String) throws -> Self {
        guard let key = Self(stringValue: name) else {
            throw Errors.invalid
        }
        return key
    }
}
