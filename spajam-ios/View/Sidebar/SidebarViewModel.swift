//
//  SidebarViewModel.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/22.
//

import SwiftUI

class SidebarViewModel: ObservableObject {
    enum SidebarState {
        case open
        case close
    }
    @Published var isOpen: SidebarState = .open
    
    func toggleSidebar() {
        self.isOpen = self.isOpen == .open ? .close : .open
    }
}
