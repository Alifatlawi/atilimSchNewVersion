//
//  ContentView.swift
//  atilimSch
//
//  Created by BLG-BC-018 on 21.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Int = 1
    var body: some View {
        TabView (selection: $selectedTab ){
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            SelectScheduleView()
                .tabItem {
                    Image(systemName: "tablecells")
                    Text("Schedule")
                }
                .tag(1)
            
            LinkView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Setting")
                }
                .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
