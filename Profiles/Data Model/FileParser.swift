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
        localData = parseString(content, withSeparators: self.separators)
        
        return localData
    }
    
    
    private func getContentFrom(_ url: URL) -> String? {
        let filePath = url.path
        guard let contentData = FileManager.default.contents(atPath: filePath) else {return nil}
        
        guard let contentString = String(data: contentData, encoding: .ascii) else {return nil}
        
        return contentString
    }
    
    private func parseString(_ contentString: String, withSeparators separatorsIn: CharacterSet) -> [[Double]] {
        var localData: [[Double]] = []
        
        let lines = contentString.components(separatedBy: .newlines)
        
        // how many columns of data
        guard let firstLine = lines.first else {return localData}
        
        let numberOfColumns = firstLine.components(separatedBy: separatorsIn).count
        
        if numberOfColumns > 0 {
            for _ in 1...numberOfColumns {
                let newArray: [Double] = []
                localData.append(newArray)
            }
        }
        
        for nextLine in lines {
            if nextLine == "" {continue}
            
            let columnData = nextLine.components(separatedBy: separatorsIn)
            
            if columnData.count != localData.count {
                return localData
            }
            
            for (columnIndex, nextString) in columnData.enumerated() {
                /*
                 if let nextData = Double(nextString) {
                     localData[columnIndex].append(nextData)
                 }
                 */
                
                let allowedCharacters = CharacterSet(charactersIn: "0123456789,.-")
                var filteredText = String(nextString.unicodeScalars.filter(allowedCharacters.contains))
                
                if filteredText == "" {
                    filteredText = String(0.0)
                }
                
                if let nextData = Double(filteredText) {
                    localData[columnIndex].append(nextData)
                }
                
            }
        }
        
        return localData
    }
}


extension FileParser {
    
    mutating func checkFunctionality() {
        guard let fileURL = Bundle.main.url(forResource: "ArrayData", withExtension: "csv") else {
            print("File does not exist ing Bundle")
            return
        }
        
        self.url = fileURL
        
        let data = parseData()
        
        print("Data from Check")
        print(data)
    }
}
