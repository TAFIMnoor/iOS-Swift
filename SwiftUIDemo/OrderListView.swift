//
//  OrderListView.swift
//  SwiftUIDemo
//
//  Created by mohammad noor uddin on 21/7/23.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                }
                Section {
                    NavigationLink("Place Order"){
                        CheckOutView()
                    }
                }
            }
            .navigationTitle("Added Items")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
            .environmentObject(Order())
    }
}
