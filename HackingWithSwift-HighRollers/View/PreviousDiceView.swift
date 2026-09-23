//
//  PreviousDiceView.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 22/09/2026.
//

import SwiftUI
import SwiftData

struct PreviousDiceView: View {
    @Environment(\.modelContext) var modelContext
    @Query var dice: [Dice]
    
    var groupedDice: [[Dice]] {
        // Group by sessionID, then sort each group by timestamp if needed
        let grouped = Dictionary(grouping: dice, by: { $0.sessionID })
            .values
            .map { Array($0) }
        
        // Sort sessions by the time of the first die in each group (most recent first)
        return grouped.sorted { ($0.first?.timeStamp ?? .distantPast) > ($1.first?.timeStamp ?? .distantPast) }
    }
    
    var body: some View {
        if groupedDice.isEmpty {
            Text("No previous rolls yet.")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
            List(groupedDice, id: \.[0].sessionID) { session in
                VStack(alignment: .leading, spacing: 6) {
                    // Show session info (date, sessionID)
                    if let firstDie = session.first {
                        Text("Rolled at \(firstDie.timeStamp.formatted(.dateTime.hour().minute().second()))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("Session: \(firstDie.sessionID.uuidString.prefix(8))")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                    
                    HStack(spacing: 16) {
                        ForEach(session) { die in
                            VStack {
                                Image(systemName: "die.face.\(die.randomNumber)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                Text("\(die.randomNumber)")
                                    .font(.caption)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}

#Preview {
    PreviousDiceView()
}
