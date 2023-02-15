//
//  ProfilesApp.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/6/23.
//

import SwiftUI

@main
struct ProfilesApp: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
