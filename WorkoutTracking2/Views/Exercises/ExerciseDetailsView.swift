//
//  ExerciseDetailsView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/5/22.
//

import SwiftUI

struct ExerciseDetailsView: View {
    
    var exercise: Exercise
    
    @AppStorage("defaultExerciseImageLoadOption") var exerciseImageDefault: String = "Form"
    
    
    var body: some View {
        TabView(selection: $exerciseImageDefault){
            VStack {
                Text("Form")
                Image(exercise.formImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 200)
            }
            .tag("Form")
            
            VStack {
                Text("Muscles")
                Image(exercise.musclesImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
            }
            .tag("Muscles")
            
        }
        .tabViewStyle(PageTabViewStyle())
        .previewLayout(.fixed(width: 400, height: 300))
        
        ScrollView {
            VStack {
                Text(exercise.name)
                    .font(.headline)
                
                Divider()
                
                if exercise.description.trimmingCharacters(in: ["\n", "\t"]) != "" {
                    VStack (alignment: .leading) {
                        ForEach(0..<exercise.description.components(separatedBy: "\n").count) { i in
                            let str = exercise.description.components(separatedBy: "\n")[i].trimmingCharacters(in: ["\n", "\t"])
                            
                            Text("**\(i+1).** \(str)")
                                .padding(.bottom, 15)
                        }
                    }
                }
                else {
                    Text("No exercise instructions found.")
                }
            }
        }
        .navigationTitle(exercise.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    
    static let exercises: [Exercise] = Bundle.main.decode("exercises.json")

    
    static var previews: some View {
        ExerciseDetailsView(exercise: exercises[0])
    }
}
