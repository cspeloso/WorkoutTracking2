//
//  WorkoutPickerListView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/7/22.
//

import SwiftUI

struct WorkoutPickerListView: View {
    
    @Binding var exercise: String
    
    var exercises: [Exercise]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                dismiss()
            } label: {
                Text("Cancel")
            }
            .foregroundColor(.blue)
            .padding()
        
            List {
                ForEach(exercises.sorted(by: {$0.name < $1.name})) { e in
                    Button{
                        exercise = e.name
                        dismiss()
                    } label: {
                        HStack {
                            Text(e.name)
                            Spacer()
                            Image(e.formImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width:76.8, height:43.2)
                                .cornerRadius(10)
                        }
                    }
                    
                    .foregroundColor(.primary)
                }
            }
        }
    }
}

struct WorkoutPickerListView_Previews: PreviewProvider {
    
    static let exercises: [Exercise] = Bundle.main.decode("exercises.json")

    var s: String = "Bench Press"
    
    static var previews: some View {
//        WorkoutPickerListView(exercise: $s, exercises: exercises)
        Text("test")
    }
}
