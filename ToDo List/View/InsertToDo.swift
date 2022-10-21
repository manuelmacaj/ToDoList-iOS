//
//  InsertToDo.swift
//  ToDo List
//
//  Created by Manuel Macaj on 21/10/22.
//

import SwiftUI

struct InsertToDo: View {
    //MARK: -Variables
    @ObservedObject var task: ToDoClass
    @Environment(\.dismiss) var dismiss
    @State private var todotext: String = ""
    @State private var sendTapped = false

    //MARK: -Body
    var body: some View {
        NavigationView {
            VStack {
                //MARK: -Form
                Form {
                    Section("Inserisci To-Do", content: {
                        TextField("ToDo", text: $todotext)
                            .padding()
                    })
                }
            }
            .navigationTitle("ToDo Insert")
            .toolbar(content: {
                //MARK: -Toolbar items
                ToolbarItem(placement:.cancellationAction){
                    Button(action: {
                        print("Cancel pressed")
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement:.confirmationAction){
                    Button(action: {
                        print("Send pressed")
                        saveToDo()
                    }) {
                        Image(systemName: "paperplane.fill")
                    }
                }
            })
        }
        .onDisappear() {
            print("Finestra chiusa")
        }
    }
    
    //MARK: -FUNCTIONS

    func saveToDo() {
        guard todotext != "" else {
            return
        }
        let newTodo = ToDo(id:String(task.ALLToDo.count + 1), todo: todotext, currentTime: Date.now.ISO8601Format(), fatto: false)
        task.ALLToDo.append(newTodo)
        dismiss()
    }
}
