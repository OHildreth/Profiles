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
    
    func parseData() throws -> [[Double]] {
        var localData: [[Double]] = []
        
        guard let unwrappedURL = url else {
            throw FileParserError.nilURL
        }
        
        // Get File Content
        guard let content = try getContentFrom(unwrappedURL) else {
            throw FileParserError.noDataAtURL(unwrappedURL)
        }
        
        
        // parseFile from Large String to Array of Doubles
        localData = try parseString(content, withSeparators: self.separators)
        
        return localData
    }
    
    
    private func getContentFrom(_ url: URL) throws -> String? {
        let filePath = url.path
        guard let contentData = FileManager.default.contents(atPath: filePath) else {throw FileParserError.noDataAtURL(url)}
        
        guard let contentString = String(data: contentData, encoding: .ascii) else {throw FileParserError.stringIsEmpty}
        
        return contentString
    }
    
    private func parseString(_ contentString: String, withSeparators separatorsIn: CharacterSet) throws -> [[Double]] {
        var localData: [[Double]] = []
        
        let lines = contentString.components(separatedBy: .newlines)
        
        // how many columns of data
        guard let firstLine = lines.first else {throw FileParserError.stringIsEmpty}
        
        let numberOfColumns = firstLine.components(separatedBy: separatorsIn).count
        
        if numberOfColumns > 0 {
            for _ in 1...numberOfColumns {
                let newArray: [Double] = []
                localData.append(newArray)
            }
        } else {
            throw FileParserError.noColumnsCreated
        }
        
        for nextLine in lines {
            if nextLine == "" {continue}
            
            let columnData = nextLine.components(separatedBy: separatorsIn)
            
            if columnData.count != localData.count {
                throw FileParserError.numberOfcolumnsShouldBeStatic
            }
            
            for (columnIndex, nextString) in columnData.enumerated() {
                
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
        
        do {
            let data = try parseData()
            print("Data from Check")
            print(data)
        } catch  {
            print(error)
        }
    }
}

extension FileParser {
    enum FileParserError: Error {
        case nilURL
        case noDataAtURL(URL)
        case stringCouldNotBeFormedFromDataAtURL(URL)
        case stringIsEmpty
        case noColumnsCreated
        case numberOfcolumnsShouldBeStatic
    }
}
