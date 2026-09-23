//
//  ContentView.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 18/09/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            RollDiceView()
                .tabItem {
                    Label("Roll Dice", systemImage: "house")
                }
            
            PreviousDiceView()
                .tabItem {
                    Label("Previous Rolls", systemImage: "dice.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
