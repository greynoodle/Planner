//
//  TodoDetail.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import SwiftUI

struct TodoDetail: View {
    @State private var isPickingSymbol = false
    @Binding var todo: Todo
    let isEditing: Bool
    
    var body: some View {
        List {
            HStack {
                Button {
                    isPickingSymbol.toggle()
                } label: {
                    Image(systemName: todo.symbol)
                        .symbolStyling()
                        .foregroundColor(todo.color)
                        .opacity(isEditing ? 0.3 : 1)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 5)

                if isEditing {
                    TextField("New Todo", text: $todo.title)
                        .font(.title2)
                } else {
                    Text(todo.title)
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            
            if isEditing {
                DatePicker("Date", selection: $todo.date)
                    .labelsHidden()
                    .listRowSeparator(.hidden)

            } else {
                HStack {
                    Text(todo.date, style: .date)
                    Text(todo.date, style: .time)
                }
                .listRowSeparator(.hidden)
            }
            
            Text("Tasks")
                .fontWeight(.bold)
            
            ForEach($todo.tasks) { $item in
                TaskRow(task: $item, isEditing: isEditing)
            }
            .onDelete(perform: { indexSet in
                todo.tasks.remove(atOffsets: indexSet)
            })
            
            Button {
                todo.tasks.append(TodoTask(text: "", isNew: true))
            } label: {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Task")
                }
            }
            .buttonStyle(.borderless)
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .sheet(isPresented: $isPickingSymbol) {
            SymbolPicker(todo: $todo)
        }
    }
}

struct TodoDetail_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetail(todo: .constant(Todo.example), isEditing: true)
            .environmentObject(TodoData())
    }
}
