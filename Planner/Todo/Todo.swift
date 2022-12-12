//
//  Todo.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import Foundation
import SwiftUI

struct Todo: Identifiable, Hashable {
    var id = UUID()
    var symbol: String = TodoSymbols.randomName()
    var color: Color = ColorOptions.random()
    var title: String = ""
    var tasks = [TodoTask(text: "")]
    var date = Date()
    
    var remainingTaskCount: Int {
        tasks.filter { !$0.isCompleted }.count
    }
    
    var isComplete: Bool {
        tasks.allSatisfy { $0.isCompleted }
    }
    
    var isPast: Bool {
        date < Date.now
    }
    
    var isWithinSevenDays: Bool {
        !isPast && date < Date.now.sevenDaysOut
    }
    
    var isWithinSevenToThirtyDays: Bool {
        !isPast && !isWithinSevenDays && date < Date.now.thirtyDaysOut
    }
    
    var isDistant: Bool {
        date >= Date().thirtyDaysOut
    }
    
    static var example = Todo(
        symbol: "case.fill",
        title: "Henry's Trip",
        tasks: [
            TodoTask(text: "Buy plane tickets"),
            TodoTask(text: "Get a new bathing suit"),
            TodoTask(text: "Find an airbnb"),
        ],
        date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 365 * 1.5)
    )
}

// Convenience methods for dates.
extension Date {
    var sevenDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 7, to: self) ?? self
    }
    
    var thirtyDaysOut: Date {
        Calendar.autoupdatingCurrent.date(byAdding: .day, value: 30, to: self) ?? self
    }
}
