//
//  ContentView.swift
//  Arvid's Todo
//
//  Created by Arvid Axelsson on 2022-10-26.
//

import SwiftUI

struct TaskObject: Hashable {
    let title: String
    var isDone = false
}

struct ContentView: View {
    @State private var inputText = ""
    @State private var todoList: [TaskObject] = [TaskObject(title: "Example"), TaskObject(title: "Another example")]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todoList, id: \.self) { object in
                    HStack {
                        Image(systemName: object.isDone ? "checkmark.square" : "square")
                        Text(object.title)
                    }
                    .onTapGesture {
                        if let index = todoList.firstIndex(of: object) {
                            todoList[index].isDone.toggle()
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        todoList.remove(at: index)
                    }
                }
                TextField("Enter task title", text: $inputText)
                    .onSubmit {
                        todoList.append(TaskObject(title: inputText))
                        inputText = ""
                    }
            }
            .navigationTitle("Arvid's Todo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
