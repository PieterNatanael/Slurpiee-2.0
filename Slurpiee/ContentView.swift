//
//  ContentView.swift
//  Slurpiee
//
//  Created by Pieter Yoshua Natanael on 15/10/23.
//

import SwiftUI
import AVFoundation

struct LightGreenTheme {
    static let primaryColor = Color(red: 0.36, green: 0.75, blue: 0.54) // Define your light green color
    static let redColor = Color.red
}

class AudioPlayerManager: ObservableObject {
    private var player: AVAudioPlayer?
    
    init() {
        guard let soundURL = Bundle.main.url(forResource: "3MinuteSlurp", withExtension: "mp3") else {
            fatalError("Sound file not found")
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.prepareToPlay()
        } catch {
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
    
    func play() {
        player?.play()
    }
    
    func stop() {
        player?.stop()
        player?.currentTime = 0
    }
}

struct ContentView: View {
    @State private var isPlaying = false
    @ObservedObject private var audioPlayerManager = AudioPlayerManager()
    
    var body: some View {
        VStack {
            Spacer()
            Image("drink1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            Button(action: {
                if isPlaying {
                    isPlaying = false
                    audioPlayerManager.stop()
                } else {
                    isPlaying = true
                    audioPlayerManager.play()
                }
            }) {
                Text(isPlaying ? "Turn Off" : "Turn On")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(isPlaying ? LightGreenTheme.redColor : Color.black)
            .cornerRadius(15)
            
            Spacer()
            
            Text("TORMENTORR")
                .font(.footnote)
                .foregroundColor(.black)
        }
        .padding()
        .background(LightGreenTheme.primaryColor.ignoresSafeArea())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
