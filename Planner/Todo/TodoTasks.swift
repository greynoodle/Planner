//
//  TodoTasks.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import Foundation

struct TodoTask: Identifiable, Hashable {
    var id = UUID()
    var text: String
    var isCompleted = false
    var isNew = false
}
