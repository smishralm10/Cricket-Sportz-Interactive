//
//  DIContainer.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 19/12/23.
//

import Foundation
import SwiftUI

struct DIContainer: EnvironmentKey {
    let interactors: Interactors
    
    init(interactors: Interactors) {
        self.interactors = interactors
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(interactors: .stub)
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(interactors: .stub)
    }
}
#endif

extension DIContainer {
    struct Interactors {
        let matchInteractor: MatchInteractorType
        
        init(matchInteractor: MatchInteractorType) {
            self.matchInteractor = matchInteractor
        }
        
        static var stub: Self {
            .init(matchInteractor: StubMatchInteractor())
        }
    }
    
}
