//
//  WorkoutDetailsView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/5/22.
//

import SwiftUI

struct WorkoutDetailsView: View {
            
    @Binding var workout: Workout
    
    var workoutName: String {
        return workout.name
    }
    
    @State private var sets: [Workout.Set] = []
    
    @State private var reps = 0
    @State private var weight = 0.0
    
    @FocusState var isWeightInputActive: Bool
    
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @State private var isShowingWorkoutPicker: Bool = false
    
    var body: some View {
        Form {
            
            //  name
            Section {
                WorkoutPicker(exercise: $workout.name)
            } header: {
                Text("Name")
            }
            
            //  add a new set
            Section {
                Picker("Reps", selection: $reps){
                    ForEach(0..<51) {
                        Text("\($0) reps")
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 90)
                
                HStack {
                    Text("Weight")
                        .font(.headline)
                    
                    Spacer()
                    
                    TextField("Weight", value: $weight, formatter: decimalFormatter)
                        .keyboardType(.decimalPad)
                        .focused($isWeightInputActive)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard){
                                Spacer()
                                
                                Button("Done"){
                                    isWeightInputActive = false
                                }
                            }
                        }
                }
                
                Button("Add to sets"){
                    let newSet = Workout.Set(reps: reps, weight: weight)
                    workout.sets.append(newSet)
                }
            } header: {
                Text("Add a new set")
            }
            
            
            //  sets
            Section {
                //  if we don't have any sets...
                if workout.sets.count == 0 {
                    Text("No sets in this workout yet.")
                }
                else{
                    List{
                        ForEach(workout.sets) { s in
                            Text("\(s.reps) reps @ \(s.weight.formatted()) lbs")
                        }
                        .onDelete(perform: deleteSet)
                    }
                }
            } header: {
                Text("Sets")
            }
            
        }
        .navigationTitle(workoutName)
    }
    
    func deleteSet(at offsets: IndexSet){
        workout.sets.remove(atOffsets: offsets)
    }
}

struct WorkoutDetailsView_Previews: PreviewProvider {
    
    @State static var workout: Workout = Workout(name: "WorkoutTest", sets: [Workout.Set(reps: 15, weight: 65), Workout.Set(reps: 15, weight: 10)])
    
    static var previews: some View {
        WorkoutDetailsView(workout: $workout)
    }
}
