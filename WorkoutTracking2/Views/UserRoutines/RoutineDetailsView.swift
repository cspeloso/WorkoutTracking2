//
//  RoutineDetailsView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/4/22.
//

import SwiftUI

struct RoutineDetailsView: View {
    
    @ObservedObject var userData: UserData
    
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
                        NavigationLink(destination: WorkoutDetailsView(userData: userData, workout: $workout)){
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
            AddWorkoutView(userData: userData, routine: $routine, workouts: routine.workouts)
        }
    }
    
    func deleteWorkout(at offsets: IndexSet){
        routine.workouts.remove(atOffsets: offsets)
    }
}

struct RoutineDetailsView_Previews: PreviewProvider {
    
    static let routine: Routine = Routine(name: "Day 1", weekday: "Monday", workouts: [])
    
    static let userData: UserData = UserData(routines: [routine])
    
    static var previews: some View {
//        RoutineDetailsView(userData: userData, routineID: routine.id)
        Text("ass")
    }
}
