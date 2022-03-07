//
//  ExerciseView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/5/22.
//

import SwiftUI

struct ExerciseView: View {
    
    let exercises: [Exercise] = Bundle.main.decode("exercises.json")

    var body: some View {
        NavigationView {
            List {
                ForEach(exercises.sorted(by: {$0.name < $1.name})) { exercise in
                    NavigationLink {
                        ExerciseDetailsView(exercise: exercise)
                    } label: {
                        Text(exercise.name)
                    }
                }
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
