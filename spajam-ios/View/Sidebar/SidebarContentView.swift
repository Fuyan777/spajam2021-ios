//
//  SidebarContentView.swift
//  spajam-ios
//
//  Created by 中村朝陽 on 2021/10/23.
//

import SwiftUI

struct SidebarContentView: View {
    private let iconSystemName: String
    private let name: String
    
    init(iconImage: String, name: String) {
        self.iconSystemName = iconImage
        self.name = name
    }
    var body: some View {
        VStack {
            HStack {
                Image(systemName: self.iconSystemName)
                    .imageScale(.large)
                    .frame(width: 32.0)
                Text(name)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }.padding(8)
        }
        
        
    }
}

struct SidebarContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SidebarContentView(iconImage: "folder.fill", name: "Files")
            SidebarContentView(iconImage: "trash", name: "Trash")
            SidebarContentView(iconImage: "person.fill", name: "Profile")
            Spacer()
        }
    }
}
