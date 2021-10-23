//
//  HomeView.swift
//  spajam-ios
//
//  Created by 山田楓也 on 2021/10/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            MatchingView()
            Text(viewModel.state.title)
            Text(viewModel.state.url)
            
            Button(action: {
                viewModel.send(.fetchData)
            }) {
                Text("Update")
            }
        }
        .padding(.all, 16)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: ViewModel(state: .init(title: "titleですう", url: "url")))
    }
}
