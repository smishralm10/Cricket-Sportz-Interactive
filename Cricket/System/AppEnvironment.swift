//
//  AppEnvironment.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 19/12/23.
//

import Foundation
import Combine

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let interactors = configuredInteractors(webRepositories: webRepositories)
        let diContainer = DIContainer(interactors: interactors)
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let matchWebRepositories = MatchWebRepository(
            session: session,
            baseURL: "https://demo.sportz.io"
        )
        return .init(matchWebrepository: matchWebRepositories)
    }
    
    private static func configuredInteractors(webRepositories: DIContainer.WebRepositories) -> DIContainer.Interactors {
        let matchInteractor = MatchInteractor(webRepository: webRepositories.matchWebrepository)
        return .init(matchInteractor: matchInteractor)
    }
}

extension DIContainer {
    struct WebRepositories {
        let matchWebrepository: MatchWebRepositoryType
    }
}
