//
//  TabBarView.swift
//  SwiftUIDemo
//
//  Created by mohammad noor uddin on 21/7/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            
            ContentView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            OrderListView()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(Order())
    }
}
