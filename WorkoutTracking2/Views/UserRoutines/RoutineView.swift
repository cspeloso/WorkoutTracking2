//
//  RoutineView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/4/22.
//

import SwiftUI

struct RoutineView: View {
    
    @ObservedObject var userData: UserData
    
    @State private var showingAddRoutine = false
    
    var body: some View {
        
        NavigationView {
            Form {
                if userData.routines.count == 0 {
                    Text("No routines created yet.")
                }
                else {
                    ForEach($userData.routines) { $routine in
                        Section {
                            VStack(alignment: .leading) {
                                NavigationLink(destination: RoutineDetailsView(routine: $routine)){
                                    Text(routine.name)
                                        .padding(.vertical, 10)
                                        .font(.headline)
                                }
                                Text("**\(routine.weekday)**")
                                    .padding(.bottom, 10)
                                    .font(.subheadline)
                                    .foregroundColor(Color(red: 255/255, green: 95/255, blue: 95/255))
                            }
                        }
                    }
                    .onDelete(perform: deleteRoutine)
                }
            }
            .navigationTitle("Routines")
            .toolbar {
                Button {
                    showingAddRoutine = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddRoutine){
                AddRoutineView(routines: $userData.routines)
            }
        }
        
    }
    
    func deleteRoutine(at offsets: IndexSet){
        userData.routines.remove(atOffsets: offsets)
    }
}

struct RoutineView_Previews: PreviewProvider {
    
    static let userData: UserData = UserData(routines: [Routine(name: "Day 1", weekday: "Monday", workouts: [Workout(name: "Bench Press", sets: [Workout.Set(reps: 12, weight: 20)])])])
    
    static var previews: some View {
        RoutineView(userData: userData)
    }
}
