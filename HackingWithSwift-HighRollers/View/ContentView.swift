//
//  ContentView.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 18/09/2026.
//

import Combine
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    
    @Environment(\.modelContext) var modelContext
    @Query var savedResults: [DiceResult]
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    Picker("Type of dice", selection: $viewModel.selectedDiceTypes) {
                        ForEach(viewModel.diceTypes, id: \.self) {
                            Text("D\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Stepper("Number of dice: \(viewModel.numberOfRoll)", value: $viewModel.numberOfRoll, in: 1...20)
                    
                    Button("Roll Dice") {
                        viewModel.rollDice(voiceOverEnabled: accessibilityVoiceOverEnabled)
                    }
                } footer: {
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(0..<viewModel.currentResult.rolls.count, id: \.self) { rollNumber in
                            Text(String(viewModel.currentResult.rolls[rollNumber]))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundStyle(.black)
                                .background(.white)
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(radius: 3)
                                .font(.title)
                                .padding(5)
                        }
                    }
                    .accessibilityElement()
                    .accessibilityLabel("Latest roll: \(viewModel.currentResult.description)") /// 'accessibilityLabel' reads the latest roll with assitive technologies.
                }
                .disabled(viewModel.stoppedDice < viewModel.currentResult.rolls.count)
                
                /// Only shows if 'savedResults' is not empty.
                if savedResults.isEmpty == false {
                    Section("Saved Results") {
                        /// Each result in 'savedResult' is shown within the dice formula and description.
                        ForEach(savedResults) { result in
                            VStack(alignment: .leading) {
                                Text("\(result.number) x \(result.type)")
                                    .font(.headline)
                                Text(result.description)
                            }
                            .accessibilityElement()
                            .accessibilityLabel("\(result.number) D\(result.type), \(result.description)") /// 'accessibilityLabel' reads the result with assitive technologies.
                        }
                    }
                }
            }
            .navigationTitle("High Rollers")
        }
        /// Runs the updateDice function when the timer changes.
        .onReceive(viewModel.timer) { _ in
            viewModel.updateDice(modelContext: modelContext)
        }
        .sensoryFeedback(.impact, trigger: savedResults.count)
    }
}

#Preview {
    ContentView()
}
