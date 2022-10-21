//
//  ToDoModel.swift
//  ToDo List
//
//  Created by Manuel Macaj on 21/10/22.
//

import Foundation
import Combine
import SwiftUI

struct ToDo: Identifiable {
    var id = String()
    var todo: String
    let currentTime: String
    var fatto: Bool
}


class ToDoClass: ObservableObject {
    @Published var ALLToDo = [ToDo]()
}
