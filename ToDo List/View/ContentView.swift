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
    @State private var isEditButton: Bool = false
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
                        ForEach(task.ALLToDo) {toDoElem in
                            NavigationLink(destination: ShowToDo(toDoSelected: toDoElem)){
                                ContentRow(todoElem: toDoElem)
                                    .contextMenu {
                                        Button {
                                            print("Edit apthic touch tapped")
                                            isEditButton = true
                                        } label: {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        Button {
                                            // Open Maps and center it on this item.
                                        } label: {
                                            Label("Delete", systemImage: "delete.left.fill")
                                        }
                                        Divider()
                                        if(toDoElem.fatto == false) {
                                            Button{
                                                markToDoCompleted(toDoSelected: toDoElem)
                                                print("Mark apthic touch tapped")
                                                
                                            } label: {
                                                Label("Mark as completed", systemImage: "checkmark")
                                            }
                                        }
                                    } preview: {
                                        ShowToDo(toDoSelected: toDoElem)
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
    private func markToDoCompleted(toDoSelected: ToDo) {
        var currentToDo = toDoSelected
        task.ALLToDo.remove(at: (Int(toDoSelected.id)! - 1))
        currentToDo.fatto = true
        task.ALLToDo.append(currentToDo)
    }
}

//MARK: - ContentRow struct
struct ContentRow: View {
    let todoElem: ToDo
    var body: some View {
        VStack {
            HStack{
                Text(todoElem.id)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.red)
                Text(todoElem.todo)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
};
struct ContentRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentRow(todoElem: ToDo(id: String(1), todo: "Prova Testo", currentTime: Date.now.ISO8601Format(), fatto: false))
    }
}



/*
 Dismiss Action (iOS 15)
 In iOS 15, Apple deprecated the presentationMode environment property, replacing it with a dismiss action. You get the dismiss action from the environment of the presented view:
 
 @Environment(\.dismiss) private var dismiss
 You then call the dismiss action directly with no need to mess with wrapped values:
 
 dismiss()
 
 https://useyourloaf.com/blog/dismissing-swiftui-views/
 
 //https://developer.apple.com/documentation/swiftui/scrollview/contextmenu(menuitems:preview:)
 */
