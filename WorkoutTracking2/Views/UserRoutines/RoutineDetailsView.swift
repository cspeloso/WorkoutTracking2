//
//  RoutineDetailsView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/4/22.
//

import SwiftUI

struct RoutineDetailsView: View {
        
    @Binding var routine: Routine
    
    
    @State private var routineName: String = ""
    
    @State private var showingWorkoutsView = false
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $routine.name)
            } header: {
                Text("Routine Name")
            }
            
            Section {
                if routine.workouts.count == 0 {
                    Section {
                        Text("No workouts found.")
                    }
                }
                else {
                    ForEach($routine.workouts) { $workout in
                        NavigationLink(destination: WorkoutDetailsView(workout: $workout)){
                            Text(workout.name)
                        }
                    }
                    .onDelete(perform: deleteWorkout)
                }
            } header: {
                Text("Workouts")
            }
        }
        .navigationTitle("Routine Details")
        .toolbar {
            Button("Add workout"){
                showingWorkoutsView = true
            }
        }
        .sheet(isPresented: $showingWorkoutsView){
            AddWorkoutView(routine: $routine)
        }
    }
    
    func deleteWorkout(at offsets: IndexSet){
        routine.workouts.remove(atOffsets: offsets)
    }
}

struct RoutineDetailsView_Previews: PreviewProvider {
    
    @State static var routine: Routine = Routine(name: "Day 1", weekday: "Monday", workouts: [])
    
    static var previews: some View {
        RoutineDetailsView(routine: $routine)
    }
}
