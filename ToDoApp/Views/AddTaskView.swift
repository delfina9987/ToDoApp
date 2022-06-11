//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by Delfina on 11/06/2022.
//

import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create a new task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Enter your task here", text: $title)
                .textFieldStyle(.roundedBorder)
            
            Button {
                print("Task added!")
            } label: {
                Text("Add task")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue: 0.083, saturation: 0.658, brightness: 0.875))
                    .cornerRadius(30)
            }
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(hue: 0.834, saturation: 0.258, brightness: 0.66))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
