//
//  StartingLayout.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/6/23.
//

import SwiftUI

struct StartingLayout: View {
    var body: some View {
        VStack {
            HStack {
                Text("Select File")
                Text("Parse File")
                Text("Flatten Data")
            }
            Divider()
            HStack {
                Text("Table")
                Divider()
                Text("Graph")
            }
        }
        
    }
}

struct StartingLayout_Previews: PreviewProvider {
    static var previews: some View {
        StartingLayout()
    }
}
