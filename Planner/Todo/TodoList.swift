//
//  TodoList.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import SwiftUI

struct TodoList: View {
    @EnvironmentObject var todoData: TodoData
    @State private var isAddingNewTodo = false
    @State private var newTodo = Todo()
    
    var body: some View {
        List {
            ForEach(Period.allCases) { period in
                if !todoData.sortedTodos(period: period).isEmpty {
                    Section(content: {
                        ForEach(todoData.sortedTodos(period: period)) { $todo in
                            NavigationLink {
                                TodoEditor(todo: $todo)
                            } label: {
                                TodoRow(todo: todo)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    todoData.delete(todo)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }, header: {
                        Text(period.name)
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .fontWeight(.bold)
                    })
                }
            }
        }
        .navigationTitle("Planner")
        .toolbar {
            ToolbarItem {
                Button {
                    newTodo = Todo()
                    isAddingNewTodo = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNewTodo) {
            NavigationView {
                TodoEditor(todo: $newTodo, isNew: true)
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TodoList()
                .environmentObject(TodoData())
        }
    }
}
