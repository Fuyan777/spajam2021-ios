//
//  HomeView.swift
//  spajam-ios
//
//  Created by 山田楓也 on 2021/10/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: SensorViewModel
    
    @State var routeType: routeType = .start
    
    var body: some View {
        ZStack {
            Image("baseball")
                .resizable()
            
            VStack {
                switch routeType {
                case .start:
                    StartView(routeType: $routeType)
                case .matching:
                    MatchingView(routeType: $routeType)
                case .batting:
                    if !viewModel.state.doneMotion {
                    ZStack {
                        if viewModel.state.battingType == .batter {
                            Image("batter")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 32)
                        } else {
                            Image("pitcher")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 32)
                        }
                        
                        VStack(alignment: .center) {
                            Image("icon")
                                .frame(width: 60, height: 60)
                                .cornerRadius(30)
                            
                            if viewModel.state.battingType == .batter {
                                Text("バッター")
                                    .font(.title)
                                    .bold()
                                Text("工藤正隆 さんのターン")
                                    .font(.title2)
                            } else {
                                Text("バッター")
                                    .font(.title)
                                    .bold()
                                Text("小林澪司 さんのターン")
                                    .font(.title2)
                            }
                            
                            Spacer().frame(height: 100)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("指示が出たら、\nお手持ちのスマートフォンを")
                                
                                if viewModel.state.battingType == .batter {
                                    Text("大きく振ってください。")
                                        .foregroundColor(.red)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                } else {
                                    Text("大きく振りかぶってください。")
                                        .foregroundColor(.red)
                                        .fontWeight(.bold)
                                        .font(.title2)
                                }
                            }
                        }.onAppear(perform: {
                            viewModel.send(.startTracking)
                        })
                    }
                    } else {
                        RecordView(routeType: $routeType)
                    }
                case .record:
                    RecordView(routeType: $routeType)
                }
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(viewModel: ViewModel(state: .init(title: "titleですう", url: "url")))
//    }
//}
