//
//  MatchingView.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/23.
//

import SwiftUI

enum MatchState {
    case preMatch
    case matching
    case matched
}

struct MatchingView: View {
    let myID = UIDevice.current.identifierForVendor?.uuidString
    @EnvironmentObject var  matchingViewModel: MatchingViewModel
    @State var count = 0
    @State var isStartWork = false
    @State var state: MatchState = .matching

    var body: some View {
        ZStack {
            if self.matchingViewModel.emenyUUID == nil {
                    ProgressView("打刻相手を探しています...")
                
            } else {
                VStack {
                    Text(self.matchingViewModel.emenyUUID ?? "")
                    Text(self.matchingViewModel.isPeripheral ? "peripheral" : "central")
                    Text("対戦相手が見つかりました")
                }
                
            }
        }
    }
}

struct MatchingView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingView()
    }
}
