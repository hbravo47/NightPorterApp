//
//  Task.swift
//  Night Porter Table View
//
//  Created by Jaboree Muhammad on 8/3/19.
//  Copyright © 2019 Jaboree Muhammad. All rights reserved.
//

import Foundation

enum taskType {
    case daily, weekly, monthly
}

struct Task {
    var name : String
    var type : taskType
    var completed: Bool
    var lastcompleted: NSDate?
}
