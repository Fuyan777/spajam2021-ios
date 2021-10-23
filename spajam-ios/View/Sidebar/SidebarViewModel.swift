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
    @Published var state: SidebarState = .open
    
    func open() {
        self.state = .open
    }
    
    func close() {
        self.state = .close
    }
    
    func toggleSidebar() {
        self.state = self.state == .open ? .close : .open
    }
}
