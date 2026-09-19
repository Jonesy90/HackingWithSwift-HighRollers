//
//  ContentView.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 18/09/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var numberOfSides = 1
    @State private var numberOfDice = 1
    
    @State private var diceRolled = false
    
    @State private var dice = [Dice]()
    
    /// Adds up the randomNumber value from each die to create a total amount.
    var totalRolled: Int { dice.reduce(0) { $0 + $1.randomNumber } }
    
    var body: some View {
        Text("High Rollers")
            .font(.largeTitle)
        
        Text("Total Rolled: \(totalRolled)")
        
        Stepper(value: $numberOfDice, in: 1...3, step: 1) {
            Text("Number of Dice: \(numberOfDice)")
        }
        
        Stepper(value: $numberOfSides, in: 1...6, step: 1) {
            Text("Number of Sides: \(numberOfSides)")
        }
        
        if diceRolled {
            HStack {
                ForEach(dice, id: \.id) { die in
                    VStack {
                        Image(systemName: "die.face.\(min(die.randomNumber + 1, 6))")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                        Text("Rolled: \(die.randomNumber + 1)")
                    }
                }
            }
            .padding()
        }
        
        Button {
            /// Updates the dice variable and maps over a range to create an array of Dice.
            dice = (1...numberOfDice).map { _ in Dice(numberOfSides: numberOfSides) }
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

#Preview {
    ContentView()
}
