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
                    VStack {
                        SidebarContentView(iconImage: "folder.fill", name: "Files")
                            .onTapGesture {
                                self.count = 0
                                self.sidebarViewModel.close()
                            }
                        SidebarContentView(iconImage: "trash", name: "Trash")
                            .onTapGesture {
                                self.count = 1
                                self.sidebarViewModel.close()
                            }
                        SidebarContentView(iconImage: "person.fill", name: "Profile")
                            .onTapGesture {
                                self.count = 2
                                self.sidebarViewModel.close()
                            }
                        Spacer()
                    }
                    
                }, contentView: {
                    VStack {
                        Button("push", action: {
                            self.sidebarViewModel.toggleSidebar()
                        })
                        if (self.count == 1) {
                                Text("Trash")
                        } else if (self.count == 2) {
                            Text("Profile")
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
            .environmentObject(SidebarViewModel())
    }
}
