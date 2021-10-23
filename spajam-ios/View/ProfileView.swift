//
//  ProfileView.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/24.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileViewModel: ProfileViewModel
    var body: some View {
        VStack {
            Text(self.profileViewModel.profileModel.name)
            Text(self.profileViewModel.profileModel.department)
            Text(self.profileViewModel.profileModel.hometown)
            Text(self.profileViewModel.profileModel.hobby)
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var profileViewModel = ProfileViewModel(profileModel: ProfileModel(uuid: "2AFB7879-2E7B-4C4B-823F-A1BA8F9C4259",
                                                                          name: "工藤正隆", department: "hogehoge部/エンジニア", hometown: "青森県", hobby: "アニメ鑑賞", profileImgUrl: "https://example.com/hoge.png"))
    static var previews: some View {
        ProfileView(profileViewModel: profileViewModel)
    }
}
