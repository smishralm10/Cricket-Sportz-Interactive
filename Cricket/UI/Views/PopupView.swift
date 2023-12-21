//
//  PopupView.swift
//  Cricket
//
//  Created by Shreyansh Mishra on 21/12/23.
//

import SwiftUI

struct PopupView: View {
    @Binding var player: Player?
    
    var body: some View {
        ZStack {
            if let player {
                Color.black
                    .opacity(0.4)
                    .ignoresSafeArea()
                
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            withAnimation(.snappy) {
                                self.player = nil
                            }
                        }
                    }
                    
                    Text(player.nameFull)
                        .font(.title2)
                    
                    HStack {
                        VStack(alignment: .center, spacing: 10) {
                            Text("Batting")
                                .font(.headline)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Style : \(player.batting.style.rawValue)")
                                    
                                    Text("Average : \(player.batting.average)")
                                    
                                    Text("Strikerate : \(player.batting.strikerate)")
                                    
                                    Text("Runs : \(player.batting.runs)")
                                }
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 10) {
                            Text("Bowling")
                                .font(.headline)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Style : \(player.bowling.style)")
                                    
                                    Text("Average : \(player.bowling.average)")
                                    
                                    Text("Economyrate : \(player.bowling.economyrate)")
                                    
                                    Text("Wickets : \(player.bowling.wickets)")
                                }
                            }
                        }
                        
                    }
                }
                .padding()
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
            }
        }
    }
}

#Preview {
    PopupView(player: .constant(Player(position: "1", nameFull: "M S Dhoni", iskeeper: true, batting: Batting(style: .rhb, average: "20", strikerate: "8", runs: "5993"), bowling: Bowling(style: "RHB", average: "38", economyrate: "839.3", wickets: "120"), iscaptain: true)))
}
