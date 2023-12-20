//
//  MatchInteractor.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 19/12/23.
//

import Foundation

protocol MatchInteractorType {
    func load(match: LoadableSubject<Game>)
}

struct MatchInteractor: MatchInteractorType {
    let webRepository: MatchWebRepositoryType
    
    func load(match: LoadableSubject<Game>) {
        let cancelBag = CancelBag()
        match.wrappedValue.setIsLoading(cancelBag: cancelBag)
        webRepository
            .loadMatch()
            .sinkToLoadable({
                print($0)
                match.wrappedValue = $0
            })
            .store(in: cancelBag)

    }
}

struct StubMatchInteractor: MatchInteractorType {
    func load(match: LoadableSubject<Game>) { }
}

