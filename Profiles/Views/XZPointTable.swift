//
//  XZPointTable.swift
//  Profiles
//
//  Created by Owen Hildreth on 2/13/23.
//

import SwiftUI

struct XZPointTable: View {
    @Binding var data: [XZPoint]
    
    var body: some View {
        Table(data) {
            TableColumn("x [µm]") {Text("\($0.xData)")}
            TableColumn("z [µm]") {Text("\($0.zData)")}
        }
    }
}

struct XZPointTable_Previews: PreviewProvider {
    static var previews: some View {
        XZPointTable(data: .constant([]))
    }
}
