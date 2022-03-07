//
//  ContentView.swift
//  WorkoutTracking2
//
//  Created by Chris Peloso on 3/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var userData: UserData = UserData()

    var body: some View {
        TabView {
            RoutineView(userData: userData)
                .tabItem {
                    Image(systemName: "list.bullet.circle.fill")
                    Text("Routines")
                }
            ExerciseView()
                .tabItem {
                    Image(systemName: "figure.walk.circle.fill")
                    Text("Exercises")
                }
            SettingsView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
