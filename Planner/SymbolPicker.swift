//
//  SymbolPicker.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import Foundation
import SwiftUI

struct SymbolPicker: View {
    @Binding var todo: Todo
    @State private var selectedColor: Color = ColorOptions.default
    @Environment(\.dismiss) private var dismiss
    @State private var symbolNames = TodoSymbols.symbolNames
    @State private var searchInput = ""
    
    var columns = Array(repeating: GridItem(.flexible()), count: 6)

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
                .padding()
            }
            HStack {
                Image(systemName: todo.symbol)
                    .font(.title)
                    .imageScale(.large)
                    .foregroundColor(selectedColor)

            }
            .padding()

            HStack {
                ForEach(ColorOptions.all, id: \.self) { color in
                    Button {
                        selectedColor = color
                        todo.color = color
                    } label: {
                        Circle()
                            .foregroundColor(color)
                    }
                }
            }
            .padding(.horizontal)
            .frame(height: 40)

            Divider()

            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(symbolNames, id: \.self) { symbolItem in
                        Button {
                            todo.symbol = symbolItem
                        } label: {
                            Image(systemName: symbolItem)
                                .symbolStyling()
                                .foregroundColor(selectedColor)
                                .padding(5)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .drawingGroup()
            }
        }
        .onAppear {
            selectedColor = todo.color
        }
    }
}

struct SymbolPicker_Previews: PreviewProvider {
    static var previews: some View {
        SymbolPicker(todo: .constant(Todo.example))
    }
}
