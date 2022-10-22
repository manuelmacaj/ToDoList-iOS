//
//  ShowToDo.swift
//  ToDo List
//
//  Created by Manuel Macaj on 21/10/22.
//

import SwiftUI

struct ShowToDo: View {
    //MARK: -Variables
    @Binding var toDoSelected: ToDo
    var body: some View {
        VStack {
            Form {
                let newFormatter = ISO8601DateFormatter()
                let date = newFormatter.date(from: toDoSelected.currentTime)!.formatted()
                Section("Dettaglio todo"){
                Text("\(toDoSelected.todo)")
                Text("\(date)")
                Text("\(String(toDoSelected.fatto))")}
            }
            .navigationTitle(Text("Detail todo"))
        }
    }
}
