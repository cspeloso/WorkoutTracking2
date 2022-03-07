//
//  AddWorkoutView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/4/22.
//

import SwiftUI

struct AddWorkoutView: View {
    
    @ObservedObject var userData: UserData

    @Binding var routine: Routine
    
    var workouts: [Workout] = []
    
    @Environment(\.dismiss) var dismiss
    
    
    let exercises: [Exercise] = Bundle.main.decode("exercises.json")
    
    @State private var reps = 10
    
    @State private var weight = 0.0
    
    @State private var sets: [Workout.Set] = []
    
    @FocusState var isWeightInputActive: Bool
    
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    
    
    @State private var isShowingWorkoutPicker = false
    
    @State private var selectedExercise: String = ""
    
    var isExerciseSelected: Bool {
        return selectedExercise == "" ? false : true
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    //  name
                    Section {
                        WorkoutPicker(exercise: $selectedExercise)                   
                    } header: {
                        Text("Workout")
                    }
                    
                    //  reps
                    Section {
                        Picker("Reps", selection: $reps) {
                            ForEach(0..<51){
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
                        
                        Button("Add"){
                            let newSet = Workout.Set(reps: reps, weight: weight)
                            sets.append(newSet)
                        }
                        
                    } header: {
                        Text("Add new set")
                    }
                    
                    //  sets list
                    Section {
                        List {
                            ForEach(sets) { s in
                                Text("\(s.reps) reps @ \(s.weight.formatted()) lbs")
                                    .padding(.vertical, 10)
                                    
                            }
                            .onDelete(perform: deleteSet)
                        }
                    } header: {
                        Text("List of sets")
                    }
                    
                }
                .navigationTitle("Add new workout")
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button("Cancel"){
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button("Save"){
                            
                            //  get the routine we're working on, and make sure the user has selected an exercise. If the user hasn't selected an exercise, nothing will happen and the button will be grayed out and disabled
                            if selectedExercise != "" {
                                let workout: Workout = Workout(name: selectedExercise, sets: sets)
                                routine.workouts.append(workout)
                                
                                dismiss()
                            }
                            
                        }
                        .foregroundColor(isExerciseSelected ? .blue : .gray)
                        .disabled(!isExerciseSelected)
                    }
                }
            }
        }
    }
    
    func deleteSet(at offsets: IndexSet){
        sets.remove(atOffsets: offsets)
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
        
    static let userData = UserData()
    
    static var previews: some View {
//        AddWorkoutView(userData: userData, routineID: userData.routines[0].id, workouts: userData.routines[0].workouts)
        Text("ass")
    }
}
