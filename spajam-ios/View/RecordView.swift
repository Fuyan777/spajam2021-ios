//
//  RecordView.swift
//  spajam-ios
//
//  Created by yamada fuuya on 2021/10/24.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Image("party")
            
            VStack(spacing: 16) {
                HStack(spacing: 56) {
                    Image("icon")
                    Image("icon")
                }
                
                HStack {
                    Text("小林澪司 さん")
                    Text("と")
                    Text("工藤正隆 さん")
                }
                
                Text("記録")
                    .bold()
                    .font(.title)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("小林澪司 さんの球速")
                        Spacer()
                        Text("150km/s")
                            .bold()
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 16)
                    
                    HStack {
                        Text("工藤正隆 さんの飛距離")
                        Spacer()
                        Text("200m")
                            .bold()
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 16)
                }
                .frame(width: UIScreen.main.bounds.width - 32, height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.white)
                )
                
                HStack(spacing: 4) {
                    Text(Date(), style: .date)
                    Text(Date(), style: .time)
                    Text("：出勤")
                }
                
                Spacer().frame(height: 50)
                
                Text("対戦相手とお話ししてみましょう！")
                
                Button(action: {
                    print("退勤")
                }) {
                    Text("終了")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 280, height: 50)
                }
                .background(Color("buttonColor"))
                .cornerRadius(16)
            }
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
