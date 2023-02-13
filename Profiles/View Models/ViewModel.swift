//
//  ViewModel.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/13/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var url: URL? = nil {
        didSet {
            // Update ProfileData
        }
    }
    
    @Published var profileData = ProfileData()
    
    
}
