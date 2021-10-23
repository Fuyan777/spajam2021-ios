//
//  ProfileViewModel.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/24.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var profileModel: ProfileModel
    
    init(profileModel: ProfileModel) {
        self.profileModel = profileModel
    }
}
