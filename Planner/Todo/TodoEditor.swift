//
//  TodoEditor.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import SwiftUI

struct TodoEditor: View {
    @EnvironmentObject var todoData: TodoData
    @Environment(\.dismiss) private var dismiss
    
    @State private var isDeleted = false
    @State private var todoCopy = Todo()
    @State private var isEditing = false
    
    @Binding var todo: Todo
    
    private var isEventDeleted: Bool {
        !todoData.exists(todo) && !isNew
    }
    var isNew = false
    
    var body: some View {
        VStack {
            TodoDetail(todo: $todoCopy, isEditing: isNew ? true : isEditing)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        if isNew {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
                    ToolbarItem {
                        Button {
                            if isNew {
                                todoData.todos.append(todoCopy)
                                dismiss()
                            } else {
                                if isEditing && !isDeleted {
                                    print("Done, saving any changes to \(todo.title).")
                                    withAnimation {
                                        todo = todoCopy // Put edits (if any) back in the store.
                                    }
                                }
                                isEditing.toggle()
                            }
                        } label: {
                            Text(isNew ? "Add" : (isEditing ? "Done" : "Edit"))
                        }
                    }
                }
                .onAppear {
                    todoCopy = todo // Grab a copy in case we decide to make edits.
                }
                .disabled(isEventDeleted)
            
            if isEditing && !isNew {
                Button(role: .destructive) {
                    isDeleted = true
                    dismiss()
                    todoData.delete(todo)
                } label: {
                    Label("Delete Todo", systemImage: "trash.circle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
                .padding()
            }
        }
        .overlay(alignment: .center) {
            if isEventDeleted {
                Color(UIColor.systemBackground)
                Text("Todo Deleted. Select a Todo.")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct TodoEditor_Previews: PreviewProvider {
    static var previews: some View {
        TodoEditor(todo: .constant(Todo()))
            .environmentObject(TodoData())
    }
}
