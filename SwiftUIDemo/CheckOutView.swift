//
//  CheckOutView.swift
//  SwiftUIDemo
//
//  Created by mohammad noor uddin on 21/7/23.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var order: Order
    
    let paymentTypes = ["Cash", "Credit Card", "BitCoins", "App Points"]
    @State private var paymentType = "Cash"
    
    @State private var addAppPoints = false
    @State private var userId = ""
    
    @State private var tipPercentage = [5, 10, 15, 20, 25]
    @State private var selectedAmount = 5
    
    @State private var orderConfirmAlert = false
    
    var total : String {
        let total = Double(order.total)
        let tipAmount = total / 100 * Double(selectedAmount)
        return (total+tipAmount).formatted(.currency(code: "BDT"))
    }
    
    var body: some View {
        Form  {
            Section {
                Picker("Select method for payment!", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.inline)
                Toggle("Already Have Account?", isOn: $addAppPoints.animation())
                if addAppPoints {
                    TextField("Enter your ID", text: $userId)
                }
            }
            
            Section("Add a tip?") {
                Picker("Precentage:", selection: $selectedAmount) {
                    ForEach(tipPercentage, id: \.self) {
                        Text("\($0)%")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Total: \(total)") {
                Button("Confirm Order") {
                    orderConfirmAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order Confirmed", isPresented: $orderConfirmAlert) {
            //
        } message: {
            Text("Total amount was \(total) - Thank You.")
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            CheckOutView()
                .environmentObject(Order())
        }
    }
}
