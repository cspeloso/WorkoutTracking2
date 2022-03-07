//
//  SettingsView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/5/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("defaultExerciseImageLoadOption") var selection = "Form"
    
    var defaultExerciseImageLoadOptions: [String] = ["Form", "Muscles"]
    
    var body: some View {
        NavigationView {
            List {
                Picker("Default Image Load", selection: $selection){
                    ForEach(defaultExerciseImageLoadOptions, id: \.self) { option in
                        Text(option)
                    }
                }
            }
            .navigationTitle("Settings")
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
