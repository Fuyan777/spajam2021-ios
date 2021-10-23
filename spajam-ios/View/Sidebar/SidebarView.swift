//
//  SidebarView.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/22.
//

import SwiftUI

struct SidebarView<SideBar: View, ContentView: View>: View {
    let sideBar: SideBar
    let contentView: ContentView
    @State private var ratio: CGFloat = 0.5
    @EnvironmentObject var sidebarViewModel: SidebarViewModel
    
    init(
        sideBar: () -> (SideBar),
        contentView: () -> (ContentView)
    ) {
        self.sideBar = sideBar()
        self.contentView = contentView()
    }
    
    var body: some View {
        ZStack {
            
            //メインビュー
            self.contentView
            
            //透過ビュー
            GeometryReader { geometry in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.sidebarViewModel.state == .open ? 1.0 : 0.0)
            .onTapGesture {
                self.sidebarViewModel.toggleSidebar()
            }
            
            //サイドバービュー
            GeometryReader { geometry in
                self.sideBar
                    .padding(.top, 48)
                    .background(Color.gray.opacity(0.6))
                    .frame(width: geometry.size.width * self.ratio, height: geometry.size.height)
                    .offset(x: self.sidebarViewModel.state == .open ? 0: -geometry.size.width * self.ratio)
                    .animation(.easeIn(duration: 0.3))
                    
            }
        }
        .ignoresSafeArea()

    }
}

extension SidebarView {
    public func setSidebarRatio(_ ratio: CGFloat) -> some View {
        var view = self
        view._ratio = State(initialValue: ratio)
        return view.id(UUID())
    }
}

struct SidebarView_Previews: PreviewProvider {
    @EnvironmentObject static var sidebarViewModel: SidebarViewModel
    static var previews: some View {
        SidebarView(
            sideBar: {
                List {
                    Text("test")
                    Text("test2")
                }
            }, contentView: {
                VStack {
                    Button("push", action: {
                        self.sidebarViewModel.toggleSidebar()
                    })
                    Text("Hello World")
                    Text("Hello World")
                    Text("Hello World")
                }
            }
        )
        .setSidebarRatio(0.4)
        .environmentObject(SidebarViewModel())
    }
}
