//
//  HackingWithSwift_HighRollersApp.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 18/09/2026.
//

import SwiftUI
import SwiftData

@main
struct HackingWithSwift_HighRollersApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Dice.self)
    }
}
