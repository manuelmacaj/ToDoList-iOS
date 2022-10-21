//
//  ShowToDo.swift
//  ToDo List
//
//  Created by Manuel Macaj on 21/10/22.
//

import SwiftUI

struct ShowToDo: View {
    //MARK: -Variables
    let toDoSelected: ToDo
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
        }
    }
}

struct ShowToDo_Previews: PreviewProvider {
    static var previews: some View {
        ShowToDo(toDoSelected: ToDo(id: String(1), todo: "Prova Testo", currentTime: Date.now.ISO8601Format(), fatto: false))
    }
}
