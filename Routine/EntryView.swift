//
//  EntryView.swift
//  Routine
//
//  Created by Hamilton, Jack on 10/13/21.
//
import SwiftUI

struct EntryView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var name: String = ""
    @State var timeStart: String = ""
    @State var timeEnd: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                    .frame(width: 100, height: 50, alignment: .leading)
                    .offset(x: 10, y: 0)
                Spacer()
                TextField(
                    "Name of your routine",
                    text: $name
                )
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("Start")
                    .frame(width: 100, height: 50, alignment: .leading)
                    .offset(x: 10, y: 0)
                Spacer()
                TextField(
                    "When you usually begin",
                    text: $timeStart
                )
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("End")
                    .frame(width: 100, height: 50, alignment: .leading)
                    .offset(x: 10, y: 0)
                Spacer()
                TextField(
                    "When you usually end",
                    text: $timeEnd
                )
                    .textFieldStyle(.roundedBorder)
            }
            Spacer()
            Button(action: {
                let newRoutine = RoutineStore(context: managedObjectContext)
                newRoutine.name = name
                if timeEnd < timeStart {
                    newRoutine.timeStart = timeEnd
                    newRoutine.timeEnd = timeStart
                } else {
                    newRoutine.timeStart = timeStart
                    newRoutine.timeEnd = timeEnd
                }
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Add")
                    .frame(width: 200, height: 35)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(50)
            }.padding(10)
        }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
    }
}
