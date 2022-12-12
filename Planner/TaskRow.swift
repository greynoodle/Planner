//
//  TaskRow.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import Foundation
import SwiftUI

struct TaskRow: View {
    @FocusState private var isFocused: Bool
    @Binding var task: TodoTask
    var isEditing: Bool

    var body: some View {
        HStack {
            Button {
                task.isCompleted.toggle()
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
            }
            .buttonStyle(.plain)

            if isEditing || task.isNew {
                TextField("Task description", text: $task.text)
                    .focused($isFocused)
                    .onChange(of: isFocused) { newValue in
                        if newValue == false {
                            task.isNew = false
                        }
                    }

            } else {
                Text(task.text)
            }

            Spacer()
        }
        .padding(.vertical, 10)
        .task {
            if task.isNew {
                isFocused = true
            }
        }
    }
        
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(task: .constant(TodoTask(text: "Do something")), isEditing: true)
    }
}
