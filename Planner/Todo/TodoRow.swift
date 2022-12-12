//
//  TodoRow.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import SwiftUI

struct TodoRow: View {
    let todo: Todo
    
    var body: some View {
        HStack {
            Image(systemName: todo.symbol)
                .symbolStyling()
                .foregroundStyle(todo.color)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(todo.title)
                    .fontWeight(.bold)
                
                Text(todo.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            if todo.isComplete {
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundStyle(.secondary)
            }
            
        }
        .badge(todo.remainingTaskCount)
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoRow(todo: Todo.example)
    }
}
