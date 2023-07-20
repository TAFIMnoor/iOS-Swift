//
//  ItemDetail.swift
//  SwiftUIDemo
//
//  Created by mohammad noor uddin on 20/7/23.
//

import SwiftUI

struct ItemDetail: View {
    
    var item: MenuItem
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing){
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                Text("Photo: \(item.photoCredit)")
                    .padding(5)
                    .background(.black)
                    .foregroundColor(.brown)
                    .offset(x: -2,y: -5)
            }
            Text(item.description)
                .padding(10)
                .fontDesign(.serif)
            
            Button("ADD TO ORDER"){
                order.add(item: item)
            }
            .buttonStyle(.bordered)
            .padding()
            
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ItemDetail(item: MenuItem.example)
                .environmentObject(Order())
        }
    }
}
