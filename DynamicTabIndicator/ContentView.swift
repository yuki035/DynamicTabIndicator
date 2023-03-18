//
//  ContentView.swift
//  DynamicTabIndicator
//
//  Created by 森祐樹 on 2023/03/18.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab: Int = 0
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $currentTab) {
                Color.red
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .tag(0)
                Color.yellow
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .tag(1)
                Color.green
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
            
            TabBarView(currentTab: $currentTab)
        }
    }
}

struct TabBarView: View {
    @Binding var currentTab: Int
    @Namespace var namespace
    var tabBarOptions: [String] = ["abcfafagaer", "defgagara", "ghigragea"]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(Array(zip(tabBarOptions.indices, tabBarOptions)), id: \.0) { index, name in
                    TabBarItem(currentTab: $currentTab,
                               namespace: namespace,
                               tabBarItemName: name,
                               tab: index)
                }
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .frame(height: 80)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    var tabBarItemName: String
    var tab: Int
    var body: some View {
        Button {
            currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline",
                                               in: namespace,
                                               properties: .frame)
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: currentTab)
        }
        .buttonStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
