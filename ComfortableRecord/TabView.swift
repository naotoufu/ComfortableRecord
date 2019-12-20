//
//  TabView.swift
//  ComfortableRecord
//
//  Created by 伊東直人 on 2019/12/13.
//  Copyright © 2019 伊東直人. All rights reserved.
//

import SwiftUI

struct TabView: View {
    @State private var selection = 0
    var body: some View {
        SwiftUI.TabView(selection: $selection){
            TableViewController(data: timelineTableData)
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
            }
            .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("second")
                        Text("Second")
                    }
                }
                .tag(1)
            Text("Third View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("third")
                        Text("Third")
                    }
                }
            .tag(2)
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
