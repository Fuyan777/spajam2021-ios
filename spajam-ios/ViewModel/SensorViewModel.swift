//
//  SensorViewModel.swift
//  spajam-ios
//
//  Created by yamada fuuya on 2021/10/23.
//

import Foundation
import CoreMotion
import Combine

enum routeType {
    case start, matching, batting, record
}

final class SensorViewModel: ViewModelProtocol {
    struct State {
        var isStarted = false
        var xMotionStr = "0.0"
        var yMotionStr = "0.0"
        var zMotionStr = "0.0"
        
        var battingType: BattingType = .pitcher // 切り替え
        var doneMotion = false
    }

    @Published private(set) var state: State
    
    private let actionPublisher: PassthroughSubject<Action, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    let motionManager = CMMotionManager()
    let voice = SoundRepository()
    
    init(state: State) {
        self.state = state
        
        actionPublisher.sink(receiveValue: { [weak self] action in
            switch action {
            case .startTracking:
                self?.startMotion()
            }
        }).store(in: &cancellables)
    }
    
    func stop() {
        self.state.isStarted = false
        motionManager.stopDeviceMotionUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopMagnetometerUpdates()
    }
    
    // MARK: Motion
    
    func startMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { motionData, error in
                self.updateMotionData(deviceMotion: motionData!)
            })
        }
        
        self.state.isStarted = true
    }
    
    // motion - 単位はG
    private func updateMotionData(deviceMotion: CMDeviceMotion) {
        self.state.xMotionStr = String(deviceMotion.userAcceleration.x)
        self.state.yMotionStr = String(deviceMotion.userAcceleration.y)
        self.state.zMotionStr = String(deviceMotion.userAcceleration.z)
        
        let zMotion = deviceMotion.userAcceleration.z
        let roll = deviceMotion.attitude.roll
        // 動作確認
        print(roll)

        if state.battingType == .pitcher && zMotion > 1.2 {
            self.stop()
            voice.playsound(name: "throw", type: "wav")
            print("投げる") //TODO: リクエストに変更
            state.doneMotion = true
        }

        if state.battingType == .batter && roll < -0.7 && zMotion > 0.5 {
            self.stop()
            voice.playsound(name: "batting", type: "mp3")
            print("打つ") //TODO: リクエストに変更
            state.doneMotion = true
        }
    }
}

extension SensorViewModel {
    enum Action {
        case startTracking
    }
    
    func send(_ action: Action) {
        actionPublisher.send(action)
    }
}
