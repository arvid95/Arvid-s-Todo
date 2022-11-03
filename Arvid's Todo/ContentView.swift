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
    let category: String
}

struct ContentView: View {
    @State private var inputText = ""
    @State private var todoList: [TaskObject] = [TaskObject(title: "Clean under sink", category: "General"), TaskObject(title: "Buy potatoes", category: "Shopping"), TaskObject(title: "Run around Munksjön", category: "Fitness"), TaskObject(title: "Complete Lab 1", category: "Studying"), TaskObject(title: "Complete Lab 2", category: "Studying")]
    @State private var categoryList = ["General", "Shopping", "Fitness", "Studying"]
    @State private var selectedCategory = "General"
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categoryList, id: \.self) { category in
                    HStack {
                        Text(category).bold()
                        Spacer()
                        switch category {
                        case "General":
                            Image(systemName: "star")
                        case "Shopping":
                            Image(systemName: "basket")
                        case "Fitness":
                            Image(systemName: "figure.walk")
                        case "Studying":
                            Image(systemName: "book")
                        default:
                            Text("Invalid category!")
                        }
                    }
                    ForEach(todoList, id: \.self) { todo in
                        if (todo.category == category) {
                            HStack {
                                Image(systemName: todo.isDone ? "checkmark.square" : "square")
                                Text(todo.title)
                            }
                            .onTapGesture {
                                if let index = todoList.firstIndex(of: todo) {
                                    todoList[index].isDone.toggle()
                                }
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            todoList.remove(at: index)
                        }
                    }
                }
                
                Section() {
                    TextField("Enter todo title", text: $inputText)
                        .onSubmit {
                            todoList.append(TaskObject(title: inputText, category: selectedCategory))
                            inputText = ""
                        }
                    Picker("Category", selection: $selectedCategory) {
                                ForEach(categoryList, id: \.self) { category in
                            Text(category)
                        }
                    }
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
