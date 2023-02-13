//
//  ContentView.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/6/23.
//

import SwiftUI

struct ContentView: View {
    @State var url: URL?
    @StateObject var profileData = ProfileData()
    
    var body: some View {
        VStack {
            HStack {
                Button("Select File") {
                    let panel = NSOpenPanel()
                    panel.allowsMultipleSelection = false
                    panel.canChooseDirectories = false
                    if panel.runModal() == .OK {
                        url = panel.url
                    }
                }
                Button("Parse File") {parseData()}
            }
            Divider()
            HSplitView {
                XZPointTable(data: $profileData.xzData)
                XZPointChart(data: profileData.xzData)
            }
            
        }
        .padding()
    }
    
    func parseData() {
        let parser = FileParser(url: url)
        let parsedData = parser.parseData()
        
        self.profileData.updateData(parsedData)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
