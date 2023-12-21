//
//  TeamInfo.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 21/12/23.
//

import SwiftUI

struct TeamInfo: View {
    let game: Game
    
    @State private(set) var teamType = 0
    @State private(set) var player: Player?
    
    var body: some View {
        ZStack {
            VStack {
                segmentControl()
                    .padding(.horizontal)
                playerList()
            }
            PopupView(player: $player)
        }
    }
    
    @ViewBuilder
    private func playerList() -> some View {
        if let teamHome = game.teams[game.matchdetail.teamHome],
           let teamAway = game.teams[game.matchdetail.teamAway] {
            if teamType == 0 {
                List {
                    Section(teamHome.nameFull) {
                        ForEach(players(for: game.matchdetail.teamHome), id: \.nameFull) {
                           playerRow(player: $0)
                        }
                    }
                    
                    Section(teamAway.nameFull)  {
                        ForEach(players(for: game.matchdetail.teamAway), id: \.nameFull) {
                           playerRow(player: $0)
                        }
                    }
                }
            }
            
            if teamType == 1 {
                List {
                    ForEach(players(for: game.matchdetail.teamHome), id: \.nameFull) {
                        playerRow(player: $0)
                    }
                }
            }
            
            if teamType == 2 {
                List {
                    ForEach(players(for: game.matchdetail.teamAway), id: \.nameFull) {
                        playerRow(player: $0)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func segmentControl() -> some View {
        if let teamHome = game.teams[game.matchdetail.teamHome],
           let teamAway = game.teams[game.matchdetail.teamAway] {
            Picker("Team", selection: $teamType) {
                Text("All").tag(0)
                Text(teamHome.nameShort).tag(1)
                Text(teamAway.nameShort).tag(2)
            }
            .pickerStyle(.segmented)
        }
    }
    
    @ViewBuilder
    private func playerRow(player: Player) -> some View {
        HStack {
            Text(player.nameFull)
            if player.iscaptain == true {
                Text("C")
                    .foregroundStyle(.orange)
            }
            
            if player.iskeeper == true {
                Text("WK")
                    .foregroundStyle(.yellow)
            }
        }
        .onTapGesture {
            withAnimation(.snappy) {
                self.player = player
            }
        }
    }
    
    private func players(for team: String) -> [Player] {
        if let team = game.teams[team] {
            return team.players.map { $0.value }
        } else {
            return []
        }
    }
}

//#Preview {
//    TeamInfo(game: )
//}
