//
//  StartView.swift
//  spajam-ios
//
//  Created by yamada fuuya on 2021/10/23.
//

import SwiftUI

struct StartView: View {    
    var body: some View {
        VStack(spacing: 0) {
            Text("2021年10月24日")
                .font(.title)
            
            Spacer().frame(height: 10)
            
            Text("10:00:10")
                .font(.system(size: 60, weight: .medium, design: .default))
            
            Spacer().frame(height: 100)
            
            Button(action: {
                print("出勤")
            }) {
                Text("出勤")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 280, height: 50)
            }
            .background(Color.blue)
            .cornerRadius(16)
            
            Spacer().frame(height: 50)
            
            Button(action: {
                print("退勤")
            }) {
                Text("退勤")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 280, height: 50)
            }
            .background(Color.blue)
            .cornerRadius(16)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

/*
 Button(action: {
     if viewModel.state.isStarted {
         viewModel.stop()
     } else {
         viewModel.send(.startTracking)
     }
 }) {
     Text("Update")
 }
 */
