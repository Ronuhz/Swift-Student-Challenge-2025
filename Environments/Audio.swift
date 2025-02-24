//
//  Audio.swift
//  (Not) Lost
//
//  Created by Hunor Zoltáni on 15.02.2025.
//

import AVKit
import Foundation
import Observation

@Observable
final class Audio {
    enum Channel {
        case effect
        case background
    }
    
    // BepBox: https://www.beepbox.co
    enum Sound: String, CaseIterable {
        case tap // recording of putting tension on a tissue paper
        case waiting // Made by me using BeepBox (Open source, MIT License)
        case failure // Made by me using BeepBox (Open source, MIT License)
        case success // Made by me using BeepBox (Open source, MIT License)
    }
    
    private var effectPlayer: AVAudioPlayer?
    private var backgroundPlayer: AVAudioPlayer?
    
    init() {
        for sound in Sound.allCases {
            play(sound, in: .effect, prepare: true)
        }
    }
    
    func stop(in channel: Channel = .effect) {
        switch channel {
            case .effect:
                effectPlayer?.stop()
            case .background:
                backgroundPlayer?.stop()
        }
    }
    
    func play(_ sound: Sound, in channel: Channel = .effect, prepare: Bool = false) {
        guard let url = getURL(for: sound) else {
            debugPrint("\(sound.rawValue) audio file not found")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            
//            Prepares the audio files
            if prepare {
                player.prepareToPlay()
                switch channel {
                    case .effect:
                        effectPlayer = player
                    case .background:
                        backgroundPlayer = player
                }
                return
            }
            
//            Individual settings for each types of audio
            switch sound {
                case .tap:
                    player.volume = Float.random(in: 0.4...0.8)
                case .waiting:
                    player.volume = 0.0
                    player.numberOfLoops = -1
                case .failure:
                    player.volume = 1.2
                case .success:
                    player.volume = 0.6
            }
            
            player.play()
            player.setVolume(0.4, fadeDuration: 0.5)
            
//            Handles playing sounds on the appropriate channel
            switch channel {
                case .effect:
                    effectPlayer = player
                case .background:
                    backgroundPlayer = player
            }
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    private func getURL(for sound: Sound) -> URL? {
        Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3")
    }
}
