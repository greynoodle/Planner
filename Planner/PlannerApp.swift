//
//  PlannerApp.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import SwiftUI

@main
struct PlannerApp: App {
    @StateObject private var todoData = TodoData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TodoList()
                Text("Select a Todo")
                    .foregroundStyle(.secondary)
            }
            .environmentObject(todoData)
        }
    }
}
