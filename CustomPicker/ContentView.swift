//
//  ContentView.swift
//  CustomPicker
//
//  Created by Federico G. Ramos on 22.01.24.
//

import SwiftUI

enum Fruit: String, CaseIterable, Identifiable {
    case apple, banana, mango, orange, strawberry, grape
    var id: String { self.rawValue }
}

struct ContentView: View {
    
    @State var selectedFruit: Fruit?
    
    var body: some View {
        VStack(spacing: 30) {
            
            CustomPicker(selection: $selectedFruit) {
                Fruit.allCases
            }
            
            Picker("Select", selection: $selectedFruit) {
                ForEach(Fruit.allCases) { fruit in
                    Text(fruit.rawValue.capitalized)
                        .tag(fruit as Fruit?)
                }
            }
            .pickerStyle(.inline)
            
            Picker("Select", selection: $selectedFruit) {
                ForEach(Fruit.allCases) { fruit in
                    Text(fruit.rawValue.capitalized)
                        .tag(fruit as Fruit?)
                }
            }
            .pickerStyle(.automatic)
            
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
        .frame(width: 280, height: 350)
        .padding()
}
