//
//  HomeView.swift
//  spajam-ios
//
//  Created by 山田楓也 on 2021/10/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: SensorViewModel

    var body: some View {
        VStack {
            Button(action: {
                viewModel.send(.startTracking)
            }) {
                Text("Update")
            }
        }
        .padding(.all, 16)
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: ViewModel(state: .init(title: "titleですう", url: "url")))
//    }
//}
