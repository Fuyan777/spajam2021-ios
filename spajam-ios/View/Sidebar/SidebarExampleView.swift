//
//  SidebarExampleView.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/23.
//

import SwiftUI

struct SidebarExampleView: View {
    @EnvironmentObject var sidebarViewModel: SidebarViewModel
    @State var count = 0
    
    var body: some View {
        ZStack {
            SidebarView(
                sideBar: {
                    List {
                        Text("test")
                            .onTapGesture {
                                self.count = 0
                                self.sidebarViewModel.toggleSidebar()
                            }
                        Text("test2")
                            .onTapGesture {
                                self.count = 1
                                self.sidebarViewModel.toggleSidebar()
                            }
                        Text("test2")
                            .onTapGesture {
                                self.count = 2
                                self.sidebarViewModel.toggleSidebar()
                            }
                    }
                }, contentView: {
                    VStack {
                        Button("push", action: {
                            self.sidebarViewModel.toggleSidebar()
                        })
                        if (self.count == 1) {
                                Text("Hello World1")
                        } else if (self.count == 2) {
                            Text("Hello World2")
                    }
                    }
                }
            )
            .setSidebarRatio(0.4)
            
        }
        .ignoresSafeArea()
        
    }
}

struct SidebarExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarExampleView()
    }
}
