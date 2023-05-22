//
//  ChartsView.swift
//  StocksPortfolio
//
//  Created by RAMESH on 14/05/23.
//

import SwiftUI
import Charts

struct ChartsView: View {
    var sector = Portfolio().investmentsPerSector()
    var body: some View {
        Chart{ ForEach(sector) { sector in
            BarMark(x: .value("Sector", sector.category.title),
                    y: .value("Allocation", sector.allocation),
                    width: MarkDimension(floatLiteral: 120)
            )
            .foregroundStyle(by : .value("Sector Allocation Title",sector.category.category))
            .annotation(position: .overlay, alignment: .center) {
                let overallreturns = String(format: "%.2f", sector.allocation)
                Text("\(overallreturns)")
                    .foregroundColor(.white)
            }
        }
     }.padding()
    }
}

struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}
