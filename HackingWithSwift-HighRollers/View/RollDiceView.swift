//
//  RollDiceview.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 22/09/2026.
//

import SwiftUI
import SwiftData

struct RollDiceView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var numberOfSides = 1
    @State private var numberOfDice = 1
    @State private var diceRolled = false
    
    @State private var dice = [Dice]()
    
    
    /// Totaling the amount rolled of each die in the dice [Dice] array.
    var totalRolled: Int {
        dice.reduce(0) {
            $0 + $1.randomNumber
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Number of Dice") {
                    Picker("", selection: $numberOfDice) {
                        ForEach(1..<4, id: \.self) { i in
                            Text("\(i)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Number of Sides") {
                    Picker("", selection: $numberOfSides) {
                        ForEach(1..<7, id: \.self) { i in
                            Text("\(i)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                if diceRolled {
                    Text("Total Rolled: \(totalRolled)")
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack {
                        ForEach(dice, id: \.id) {die in
                            VStack {
                                Image(systemName: "die.face.\(die.randomNumber)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                }
            }
            .navigationTitle("High Roller")
            
            Button {
                /// Create a sessionID that will be assigned to newDice. This will later be used to group Dice based off their sessionID.
                let sessionID = UUID()
                let newDice: [Dice] = (1...numberOfDice).map { _ in Dice(numberOfSides: numberOfSides, sessionID: sessionID) }
                newDice.forEach { die in
                    /// Each die in newDice [Dice] will be persisted to SwiftData.
                    modelContext.insert(die)
                }
                
                dice = newDice
                
                diceRolled = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 200, height: 50)
                        .padding()
                    
                    Text("Roll Dice")
                        .foregroundStyle(.white)
                        .font(.title)
                }
            }
        }
    }
}

#Preview {
    RollDiceView()
}
