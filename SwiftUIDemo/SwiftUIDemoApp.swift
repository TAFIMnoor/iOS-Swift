//
//  SwiftUIDemoApp.swift
//  SwiftUIDemo
//
//  Created by mohammad noor uddin on 20/7/23.
//

import SwiftUI

@main
struct SwiftUIDemoApp: App {
    
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(order)
        }
    }
}
