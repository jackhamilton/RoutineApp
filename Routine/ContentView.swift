//
//  ContentView.swift
//  Routine
//
//  Created by Hamilton, Jack on 10/11/21.
//

import SwiftUI

struct ContentView: View {
    
    //TODO: Change EntryView to use time pickers.
    //TODO: Highlight active routine elements
    //TODO: Swipe to delete
    //TODO: MVVM
    
    @FetchRequest(
        entity: RoutineStore.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \RoutineStore.name, ascending: true),
        ]
    ) var routinesFetch: FetchedResults<RoutineStore>
    
    var storedRoutines: [Routine] {
        get {
            var routinesInternal: [Routine] = []
            for routineEntity in routinesFetch {
                routinesInternal.append(
                    Routine(name: routineEntity.name ?? "", timeStart: routineEntity.timeStart ?? "", timeEnd: routineEntity.timeEnd ?? "")
                )
            }
            return routinesInternal.sorted()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(storedRoutines) { routine in
                    RoutineRow(routine: routine)
                }
                    .navigationTitle("Your Routine")
                    .navigationBarTitleDisplayMode(.inline)
                    .padding()
                Spacer()
                Button(action: {}) {
                    NavigationLink(destination: EntryView()) {
                            Text("+")
                                .frame(width: 200, height: 35)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(50)
                    }
                }.padding(10)
            }
        }
    }
}

struct RoutineRow: View {
    var routine: Routine
    
    var body: some View {
        HStack {
            Text(routine.name)
            Spacer()
            Text(String("\(routine.timeStart) -  \(routine.timeEnd)"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
