//
//  MatchWebRepository.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 19/12/23.
//

import Foundation
import Combine

protocol MatchWebRepositoryType: WebRepository {
    func loadMatch() -> AnyPublisher<Game, Error>
}

struct MatchWebRepository: MatchWebRepositoryType {
    var session: URLSession
    var baseURL: String
    var bgQueue: DispatchQueue
    
    func loadMatch() -> AnyPublisher<Game, Error> {
        return call(endpoint: API.home)
    }
    
}

// MARK: - Endpoints

extension MatchWebRepository {
    enum API {
        case home
    }
}

extension MatchWebRepository.API: APICall {
    var path: String {
        switch self {
        case .home:
            return "/nzin01312019187360.json"
        }
    }
    
    var method: String {
        switch self {
        case .home:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
    
    func body() throws -> Data? {
        return nil
    }
}


