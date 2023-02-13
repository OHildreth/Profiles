//
//  XZPointChart.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/13/23.
//

import SwiftUI
import Charts

struct XZPointChart: View {
    var data: [XZPoint]
    
    var body: some View {
        Chart {
            ForEach(data) { point in
                LineMark(x: .value("Position [µm]", point.xData),
                         y: .value("Height [µm]", point.zData))
            }
        }
        // Give the chart a white background
        .chartPlotStyle{ plotArea in
            plotArea.background(.white)
        }
        // Loate the marks
        .chartXAxis{
            AxisMarks(position: .bottom)
        }
        // Give the X-axis a label
        .chartXAxisLabel(alignment: .center) {
            Text("Position [μm]")
        }
        .chartYAxis{
            AxisMarks(position: .leading)
        }
        .chartYAxisLabel(alignment: .leadingFirstTextBaseline) {
            Text("Height [μm]")
        }
        .frame(height: 300)
        
    }
}

struct XZPointChart_Previews: PreviewProvider {
    static var previews: some View {
        XZPointChart(data: [])
    }
}
