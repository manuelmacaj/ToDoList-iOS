//
//  ContentView.swift
//  ToDo List
//
//  Created by Manuel Macaj on 21/10/22.
//


import SwiftUI
import Combine

//MARK: -Content View
struct ContentView: View {
    //MARK: -Variables
    @State private var isButtonTapped: Bool = false
    @State private var editButtonTapped: Bool = false
    @State private var isItemTapped: Bool = false
    @ObservedObject var task = ToDoClass()
    //MARK: -Body
    var body: some View {
        //MARK: -Navigation
        NavigationView{
            VStack {
                if(task.ALLToDo.isEmpty){
                    Text("Add new todo")
                }
                else{
                    //MARK: -List
                    List{
                        ForEach(task.ALLToDo.indices, id: \.self) {idToDo in
                            NavigationLink(destination: ShowToDo(toDoSelected: $task.ALLToDo[idToDo])){
                                ContentRow(todoElem: $task.ALLToDo[idToDo])
                                    .contextMenu {
                                        Button {
                                            print("Edit apthic touch tapped")
                                            
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        Button {
                                            // Open Maps and center it on this item.
                                            print("ContentView: Delete apthic touch tapped")
                                            deleteItemFromList(id: idToDo)
                                        } label: {
                                            Label("Delete", systemImage: "delete.left.fill")
                                        }
                                        Divider()
                                        if(task.ALLToDo[idToDo].fatto == false) {
                                            Button{
                                                task.ALLToDo[idToDo].fatto = true
                                                print("ContentView: Mark apthic touch tapped")
                                                
                                            } label: {
                                                Label("Mark as completed", systemImage: "checkmark")
                                            }
                                        }
                                    } preview: {
                                        ShowToDo(toDoSelected: $task.ALLToDo[idToDo])
                                    }
                            }
                        }
                        .onDelete(perform: self.delete)
                    }
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                Button(action: {
                    print("Add button pressed")
                    self.isButtonTapped = true
                }){
                    Image(systemName: "plus")
                }
                .sheet(isPresented: self.$isButtonTapped, content: {
                    InsertToDo(task: task)
                })
            }
        }
    }
    //MARK: -Functions
    private func delete(offset: IndexSet) {
        self.task.ALLToDo.remove(atOffsets: offset)
    }
    private func deleteItemFromList(id: Int){
        task.ALLToDo.remove(at: id)
    }
}

//MARK: - ContentRow struct
struct ContentRow: View {
    @Binding var todoElem: ToDo
    @State private var isShowToDoTapped: Bool = false
    var body: some View {
        VStack {
            Text(todoElem.todo)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
};



/*
 Dismiss Action (iOS 15)
 In iOS 15, Apple deprecated the presentationMode environment property, replacing it with a dismiss action. You get the dismiss action from the environment of the presented view:
 
 @Environment(\.dismiss) private var dismiss
 You then call the dismiss action directly with no need to mess with wrapped values:
 
 dismiss()
 
 https://useyourloaf.com/blog/dismissing-swiftui-views/
 
 //https://developer.apple.com/documentation/swiftui/scrollview/contextmenu(menuitems:preview:)
 */
