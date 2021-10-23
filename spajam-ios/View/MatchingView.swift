//
//  MatchingView.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/23.
//

import SwiftUI

struct MatchingView: View {
    @EnvironmentObject var  matchingViewModel: MatchingViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Button("test", action: {
                    self.matchingViewModel.startDiscover()
                })
                Button("test2", action: {
                    self.matchingViewModel.sendString("testtesttesttest")
                })
            }
            
        }
    }
}

struct MatchingView_Previews: PreviewProvider {
    static var previews: some View {
        MatchingView()
    }
}
