//
//  ItemRow.swift
//  SwiftUIDemo
//
//  Created by mohammad noor uddin on 20/7/23.
//

import SwiftUI

struct ItemRow: View {
    var item: MenuItem
    let color : [String:Color] = ["G" : .green,
                                  "D" : .brown,
                                  "V" : .black,
                                  "S" : .cyan,
                                  "N" : .orange]
    
    var body: some View {
        HStack {
            Image(item.thumbnailImage)
                .clipShape(Circle())
                .overlay(Circle().stroke(.gray))
            
            VStack(alignment: .listRowSeparatorLeading) {
                Text(item.name)
                    .font(.headline)
                Text("$\(item.price)")
            }
            .foregroundColor(.accentColor)
            .padding(2)
            
            Spacer()
            
            ForEach(item.restrictions, id: \.self) { restriction in
                Text(restriction)
                    .font(.caption)
                    .padding(5)
                    .fontWeight(.black)
                    .background(color[restriction])
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: MenuItem.example)
    }
}
