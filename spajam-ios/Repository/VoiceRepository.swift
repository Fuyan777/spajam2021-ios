//
//  VoiceRepository.swift
//  spajam-ios
//
//  Created by yamada fuuya on 2021/10/23.
//

import Foundation
import AVFoundation

protocol VoiceRepositoryProtocol {
    func playsound(name: String, type: String)
}

class VoiceRepository: VoiceRepositoryProtocol {
    var audioPlayer: AVAudioPlayer!
    func playsound(name: String, type: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            print("音源ファイルが見つかりません")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error{
            print(error)
            print(error.localizedDescription)
        }
    }
}
