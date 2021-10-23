//
//  BattingUserView.swift
//  spajam-ios
//
//  Created by yamada fuuya on 2021/10/23.
//

import SwiftUI

enum BattingType: CaseIterable {
    case pitcher
    case batter
}

struct BattingUserView: View {
    @Binding var routeType: routeType
    var battingType: BattingType = .pitcher
    
    init(routeType: Binding<routeType>) {
        self._routeType = routeType
    }
    
    var body: some View {
        ZStack {
            if battingType == .batter {
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
                
                if battingType == .batter {
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
                    
                    if battingType == .batter {
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
            }
        }
    }
}

//struct BattingUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        BattingUserView()
//    }
//}
