//
//  WorkoutPicker.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/7/22.
//

import SwiftUI

struct WorkoutPicker: View {
    
    @Binding var exercise: String

    @State private var isShowingWorkoutPicker = false
    
    @Environment(\.dismiss) var dismiss
    
    let exercises: [Exercise] = Bundle.main.decode("exercises.json")

    var body: some View {
        
        //  The button showing the currently selected exercise
        Button {
            isShowingWorkoutPicker = true
        } label: {
            HStack {
                Text(exercise != "" ? exercise : "Select a workout...")
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .foregroundColor(.primary)
        .sheet(isPresented: $isShowingWorkoutPicker){
            //  opens the list of exercises to swap to
            WorkoutPickerListView(exercise: $exercise, exercises: exercises)
        }
    }
}

struct WorkoutPicker_Previews: PreviewProvider {


    
    static var previews: some View {
//        WorkoutPicker(exercise: $e)
        Text("test")
    }
}
