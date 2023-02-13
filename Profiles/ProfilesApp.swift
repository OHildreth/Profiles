//
//  ProfilesApp.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/6/23.
//

import SwiftUI

@main
struct ProfilesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print("ContentView.onAppear is working")
                    var parser = FileParser()
                    
                    parser.checkFunctionality()
                }
        }
    }
}
