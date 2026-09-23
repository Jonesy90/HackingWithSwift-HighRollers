//
//  ViewModel-ContentView.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 23/09/2026.
//

import Combine
import SwiftUI
import SwiftData

extension ContentView {
    @Observable
    class ViewModel {
        let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        let diceTypes = [4, 6, 8, 10, 12, 20, 100]
        let columns: [GridItem] = [
            .init(.adaptive(minimum: 60))
        ]
        
        var selectedDiceTypes = 6
        var numberOfRoll = 4
        var stoppedDice = 0
        
        var currentResult = DiceResult(type: 0, number: 0)
        
        func rollDice(voiceOverEnabled: Bool) {
            if voiceOverEnabled {
                stoppedDice = numberOfRoll
            } else {
                stoppedDice = -20
            }
            
            currentResult = DiceResult(type: selectedDiceTypes, number: numberOfRoll)
        }
        
        func updateDice(modelContext: ModelContext) {
            guard stoppedDice < currentResult.rolls.count else { return }
            
            for i in stoppedDice..<numberOfRoll {
                if i < 0 { continue }
                currentResult.rolls[i] = Int.random(in: 1...selectedDiceTypes)
            }
            
            stoppedDice += 1
            
            if stoppedDice == numberOfRoll {
                modelContext.insert(currentResult)
            }
        }
    }
}
