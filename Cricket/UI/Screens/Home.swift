//
//  Home.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 20/12/23.
//

import SwiftUI

struct Home: View {
    @State private(set) var game: Loadable<Game>
    
    @Environment(\.injected) private var injected
    
    init(game: Loadable<Game> = .notRequested) {
        self._game = .init(initialValue: game)
    }
    
    var body: some View {
        content
            .navigationTitle("Game")
    }
    
    @ViewBuilder private var content: some View {
        switch game {
        case .notRequested:
            notRequestedView
        case let .isLoading(last, _):
            loadingView(last)
        case let .loaded(game):
           loadedView(game, isLoading: false)
        case let .failed(error):
            failedView(error)
        }
    }
}

// MARK: - Side Effects
private extension Home {
    func loadMatch() {
        injected.interactors
            .matchInteractor
            .load(match: $game)
    }
    
}

// MARK: - Loading Content
private extension Home {
    var notRequestedView: some View {
        Color.clear
            .onAppear(perform: loadMatch)
    }
    
    func loadingView(_ previouslyLoaded: Game?) -> some View {
        if let game = previouslyLoaded {
            return AnyView(loadedView(game, isLoading: true))
        } else {
            return AnyView(
                ProgressView()
                    .progressViewStyle(.circular)
            )
        }
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error) {
            self.loadMatch()
        }
    }
}

// MARK: - Displaying Content
private extension Home {
    @ViewBuilder
    func loadedView(_ game: Game, isLoading: Bool) -> some View {
        if let teamHome = game.teams[game.matchdetail.teamHome],
           let teamAway = game.teams[game.matchdetail.teamAway] {
            VStack {
                VStack(spacing: 15) {
                    VStack {
                        Text(game.matchdetail.venue.name)
                            .font(.callout)
                        let date = DateFormatter.dayAndMonth(from: game.matchdetail.match.date)
                        Text("\(date) \(game.matchdetail.match.time)")
                            .font(.caption)
                    }
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Text(teamHome.nameShort)
                                .font(.headline)
                            Text(
                                score(
                                    for: game.matchdetail.teamHome,
                                    innings: game.innings
                                )
                            )
                            .foregroundStyle(.secondary)
                        }
                        Spacer()
                        
                        Text("VS")
                        
                        Spacer()
                        
                        VStack {
                            Text(teamAway.nameShort)
                                .font(.headline)
                            Text(
                                score(
                                    for: game.matchdetail.teamAway,
                                    innings: game.innings
                                )
                            )
                            .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    Text(game.matchdetail.result)
                        .font(.footnote)
                    NavigationLink {
                        TeamInfo(game: game)
                    } label: {
                        Text("Team Info")
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.caption)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.background)
                )
                .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.thinMaterial)
        }
    }
    
    func score(for team: String, innings: [Inning]) -> String {
        for inning in innings {
            if inning.battingteam == team {
                return "(\(inning.total)/\(inning.wickets))"
            }
        }
        return "(- -)"
    }
}

extension DateFormatter {
    static func dayAndMonth(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        let date = formatter.date(from: dateString)
        if let date = date {
            formatter.dateFormat = "dd MMM, YYYY"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
}


#Preview {
    ContentView()
}
