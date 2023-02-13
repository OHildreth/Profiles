//
//  LinearRegression.swift
//  QuadraticFitting
//
//  Created by Owen Hildreth on 12/2/21.
//

import Foundation

struct LinearFit {
    // for a·x + b = 0
    
    var a:Double
    var b:Double
}


 
 class LinearRegression {
     // for a·x + b = 0
     
     // a = ( Σ[(x_i - x_m)·(y_i - y_m)] ) / (Σ[(x_i - x_m)^2]
     // b = y_m - a·x_m
     
     func calculateLinearRegression(for dataIn: [XZPoint]) -> LinearFit? {
         // Can't do a linear regression if there is no data
         if dataIn.count == 0 {
             return nil
         }
         
         var xSum = 0.0
         var zSum = 0.0
         
         for nextPoint in dataIn {
             xSum += nextPoint.xData
             zSum += nextPoint.zData
         }
         
         // notice that dataIn.count is an integer
         let xMean = xSum/Double(dataIn.count)
         let zMean = zSum/Double(dataIn.count)
         
         
         var numerator = 0.0
         var denominator = 0.0
         
         for nextPoint in dataIn {
             let xDiff = nextPoint.xData - xMean
             let yDiff = nextPoint.zData - zMean
             
             numerator += xDiff*yDiff
             denominator += xDiff*xDiff
         }
         
         let a = numerator/denominator
         let b = zMean - a*xMean
         
         return LinearFit(a: a, b: b)
     }
 }

 
 
