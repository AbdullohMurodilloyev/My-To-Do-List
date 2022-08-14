//
//  Task.swift
//  My To Do List
//
//  Created by Abdulloh Murodilloyev on 17/03/22.
//

import Foundation


enum TaskState {
    case new
    case finishid
    case archived
}


struct Task {
    var title: String
    var description: String
    var state: TaskState = .new
    var prioriry: TaskPriority
    var subtasks: [SubTask]
}
