//
//  TodoData.swift
//  Planner
//
//  Created by Yusif Tijani on 12/12/22.
//

import Foundation
import SwiftUI

class TodoData: ObservableObject {
    @Published var todos: [Todo] = [
        Todo(
            symbol: "gift.fill",
            color: .red,
            title: "Maya's Birthday",
            tasks: [TodoTask(text: "Guava kombucha"),
                    TodoTask(text: "Paper cups and plates"),
                    TodoTask(text: "Cheese plate"),
                    TodoTask(text: "Party poppers"),
                   ],
            date: Date.roundedHoursFromNow(60 * 60 * 24 * 30)
        ),
        Todo(
            symbol: "theatermasks.fill",
            color: .yellow,
            title: "Pagliacci",
            tasks: [TodoTask(text: "Buy new tux"),
                    TodoTask(text: "Get tickets"),
                    TodoTask(text: "Pick up Carmen at the airport and bring her to the show"),
                   ],
            date: Date.roundedHoursFromNow(60 * 60 * 22)
        ),
        Todo(
            symbol: "facemask.fill",
            color: .indigo,
            title: "Doctor's Appointment",
            tasks: [TodoTask(text: "Bring medical ID"),
                    TodoTask(text: "Record heart rate data"),
                   ],
            date: Date.roundedHoursFromNow(60 * 60 * 24 * 4)
        ),
        Todo(
            symbol: "leaf.fill",
            color: .green,
            title: "Camping Trip",
            tasks: [TodoTask(text: "Find a sleeping bag"),
                    TodoTask(text: "Bug spray"),
                    TodoTask(text: "Paper towels"),
                    TodoTask(text: "Food for 4 meals"),
                    TodoTask(text: "Straw hat"),
                   ],
            date: Date.roundedHoursFromNow(60 * 60 * 36)
        ),
        Todo(
            symbol: "gamecontroller.fill",
            color: .cyan,
            title: "Game Night",
            tasks: [TodoTask(text: "Find a board game to bring"),
                    TodoTask(text: "Bring a desert to share"),
                   ],
            date: Date.roundedHoursFromNow(60 * 60 * 24 * 2)
        ),
        Todo(
            symbol: "graduationcap.fill",
            color: .primary,
            title: "First Day of Work",
            tasks: [
                TodoTask(text: "Macbook"),
                TodoTask(text: "Charger"),
                TodoTask(text: "Binder"),
                TodoTask(text: "First day of work outfit"),
            ],
            date: Date.roundedHoursFromNow(60 * 60 * 24 * 365)
        ),
        Todo(
            symbol: "book.fill",
            color: .purple,
            title: "Book Launch",
            tasks: [
                TodoTask(text: "Finish first draft"),
                TodoTask(text: "Send draft to editor"),
                TodoTask(text: "Final read-through"),
            ],
            date: Date.roundedHoursFromNow(60 * 60 * 24 * 365 * 2)
        ),
        Todo(
            symbol: "globe.americas.fill",
            color: .gray,
            title: "WWDC",
            tasks: [
                TodoTask(text: "Watch Keynote"),
                TodoTask(text: "Watch What's new in SwiftUI"),
                TodoTask(text: "Go to DT developer labs"),
                TodoTask(text: "Learn about Create ML"),
            ],
            date: Date.from(month: 6, day: 7, year: 2021)
        )
    ]
    
    func delete(_ todo: Todo) {
        todos.removeAll { $0.id == todo.id }
    }
    
    func add(_ todo: Todo) {
        todos.append(todo)
    }
    
    func exists(_ todo: Todo) -> Bool {
        todos.contains(todo)
    }
    
    func sortedTodos(period: Period) -> Binding<[Todo]> {
        Binding<[Todo]>(
            get: {
                self.todos
                    .filter {
                        switch period {
                        case .nextSevenDays:
                            return $0.isWithinSevenDays
                        case .nextThirtyDays:
                            return $0.isWithinSevenToThirtyDays
                        case .future:
                            return $0.isDistant
                        case .past:
                            return $0.isPast
                        }
                    }
                    .sorted { $0.date < $1.date }
            },
            set: { todos in
                for todo in todos {
                    if let index = self.todos.firstIndex(where: { $0.id == todo.id }) {
                        self.todos[index] = todo
                    }
                }
            }
        )
    }
}

enum Period: String, CaseIterable, Identifiable {
    case nextSevenDays = "Next 7 Days"
    case nextThirtyDays = "Next 30 Days"
    case future = "Future"
    case past = "Past"
    
    var id: String { self.rawValue }
    var name: String { self.rawValue }
}

extension Date {
    static func from(month: Int, day: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar(identifier: .gregorian)
        if let date = calendar.date(from: dateComponents) {
            return date
        } else {
            return Date()
        }
    }
    
    static func roundedHoursFromNow(_ hours: Double) -> Date {
        let exactDate = Date(timeIntervalSinceNow: hours)
        guard let hourRange = Calendar.current.dateInterval(of: .hour, for: exactDate) else {
            return exactDate
        }
        return hourRange.end
    }
}
