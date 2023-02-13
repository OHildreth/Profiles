//
//  ProfileData.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/6/23.
//

import Foundation

class ProfileData: ObservableObject {
    @Published var xzData: [XZPoint] = []
    
    func updateData(_ dataIn: [[Double]]) {
        var localData: [XZPoint] = []
        
        if dataIn.count < 2 {
            return
        }
        
        // extract the columns
        let xData = dataIn[0]
        let zData = dataIn[1]
        
        
        // Get the lengths of th data
        let numberOfPoints = xData.count
        
        if xData.count != zData.count {
            return
        }
        
        localData.reserveCapacity(numberOfPoints)
        
        for index in 0..<numberOfPoints {
            let nextPoint = XZPoint(xData: xData[index], zData: zData[index])
            
            localData.append(nextPoint)
            
        }
        
        xzData = localData
    }
    
    func flattenData() {
        let regression = LinearRegression()
        
        let fit = regression.calculateLinearRegression(for: self.xzData)
        
        var newData: [XZPoint] = []
        newData.reserveCapacity(xzData.count)
        
        for nextPoint in xzData {
            let zOffset = (fit?.b ?? 0.0) + (fit?.a ?? 0.0 ) * nextPoint.xData
            
            let newZ = nextPoint.zData - zOffset
            
            let newPoint = XZPoint(xData: nextPoint.xData, zData: newZ)
            
            newData.append(newPoint)
        }
        
        self.xzData = newData
    }
}
