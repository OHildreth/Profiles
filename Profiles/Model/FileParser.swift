//
//  FileParser.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/6/23.
//

import Foundation


struct FileParser {
    var url: URL? = nil
    
    var separators = CharacterSet(charactersIn: ",")
    
    func parseData() -> [[Double]] {
        var localData: [[Double]] = []
        
        guard let unwrappedURL = url else {
            return localData
        }
        
        // Get File Content
        guard let content = getContentFrom(unwrappedURL) else {
            return localData
        }
        
        
        // parseFile from Large String to Array of Doubles
        
        
        return localData
    }
    
    
    private func getContentFrom(_ url: URL) -> String? {
        let filePath = url.path
        guard let contentData = FileManager.default.contents(atPath: filePath) else {return nil}
        
        guard let contentString = String(data: contentData, encoding: .ascii) else {return nil}
        
        return contentString
    }
    
}
