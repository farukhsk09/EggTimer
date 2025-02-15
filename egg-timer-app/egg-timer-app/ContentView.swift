//
//  ContentView.swift
//  egg-timer-app
//
//  Created by Sameer shaik on 2/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 0
    @State private var totalTime = 0
    @State private var timerRunning = false
    @State private var timer: Timer?
    @State private var eggReady = false
    @State private var hasStarted = false
    
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 8] // Time in seconds
    
    var body: some View {
        VStack(alignment: .center) {
            Text("🥚 Egg Timer")
                .font(.largeTitle)
                .foregroundColor(Color.primary)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 20) {
                ForEach(eggTimes.keys.sorted(), id: \..self) { egg in
                    Button(action: {
                        startTimer(for: eggTimes[egg]!)
                    }) {
                        Text(egg)
                            .font(.headline)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .foregroundColor(Color.primary)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding()
            
            Spacer()
            
            Text(eggReady ? "🥚➡️🍳" : "🥚")
                .font(.system(size: 100))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .foregroundColor(Color.primary)
            
            if hasStarted && !eggReady {
                ProgressView(value: Double(timeRemaining), total: Double(totalTime))
                    .padding()
                
                Text("\(timeRemaining) seconds left")
                    .font(.headline)
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground).ignoresSafeArea())
    }
    
    func startTimer(for seconds: Int) {
        timer?.invalidate()
        totalTime = seconds
        timeRemaining = seconds
        timerRunning = true
        eggReady = false
        hasStarted = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerRunning = false
                eggReady = true
            }
        }
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark) // Preview dark mode
        ContentView()
            .preferredColorScheme(.light) // Preview light mode
    }
}
