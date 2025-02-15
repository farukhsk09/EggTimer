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
    
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 8] // Time in seconds
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("🥚 Egg Timer")
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(alignment: .leading) {
                ForEach(eggTimes.keys.sorted(), id: \..self) { egg in
                    Button(action: {
                        startTimer(for: eggTimes[egg]!)
                    }) {
                        Text(egg)
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.leading)
            
            Spacer()
            
            Text(eggReady ? "🐣⏲️" : "🥚")
                .font(.system(size: 100))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            
            ProgressView(value: Double(timeRemaining), total: Double(totalTime))
                .padding()
            
            Text("\(timeRemaining) seconds left")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
        }
        .padding()
    }
    
    func startTimer(for seconds: Int) {
        timer?.invalidate()
        totalTime = seconds
        timeRemaining = seconds
        timerRunning = true
        eggReady = false
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


