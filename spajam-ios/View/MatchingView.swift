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
    @EnvironmentObject var matchingViewModel: MatchingViewModel

    @State var count = 0
    @State var isStartWork = false
    @State var state: MatchState = .matching
    
    @Binding var routeType: routeType
    
    init(routeType: Binding<routeType>) {
        self._routeType = routeType
    }

    var body: some View {
        ZStack {
            if self.matchingViewModel.emenyUUID == nil {
                ProgressView("打刻相手を探しています...")
            } else {
                VStack {
                    Text("対戦相手が見つかりました")
                    Button(action: {
                        routeType = .batting
                    }) {
                        Text("はじめましょう！")
                    }
                }                
            }
        }
    }
}
//
//struct MatchingView_Previews: PreviewProvider {
//    @State var routeType: routeType = .start
//    static var previews: some View {
//        MatchingView(routerType: $routeType)
//    }
//}
