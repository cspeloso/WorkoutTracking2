//
//  AddRoutineView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/4/22.
//

import SwiftUI

struct AddRoutineView: View {
    
    @ObservedObject var userData: UserData
    
    var routines: [Routine]
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    
    @State private var selectedWeekday: String = ""
    
    let weekdays = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday", ""]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    Picker("Week day", selection: $selectedWeekday) {
                        ForEach(weekdays, id: \.self){
                            if $0 == "" {
                                Text("No day")
                            }
                            else {
                                Text($0)
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("Weekday")
                }
            }
            .navigationTitle("Create new routine")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                    Button("Save"){
                        let routine: Routine = Routine(name: name, weekday: selectedWeekday, workouts: [])
                        userData.routines.append(routine)
                        
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddRoutineView_Previews: PreviewProvider {
    
    static let routines: [Routine] = []
    
    static let userData: UserData = UserData(routines: routines)    
    
    static var previews: some View {
        AddRoutineView(userData: userData, routines: routines)
    }
}
