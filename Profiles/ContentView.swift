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
                FlattenDataButtonView()
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
        
        do {
            let parsedData = try parser.parseData()
            self.profileData.updateData(parsedData)
        } catch {
            print(error)
        }
    }
    
    @ViewBuilder
    func FlattenDataButtonView() -> some View {
        Button("Flatten Data") {
            self.profileData.flattenData()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
