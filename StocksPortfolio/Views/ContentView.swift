//
//  ContentView.swift
//  StocksPortfolio
//
//  Created by RAMESH on 13/05/23.
//

import SwiftUI

struct ContentView: View {
    var sector = Portfolio().investmentsPerSector()
    var body: some View {
        TabContainerView()
    }
}
struct TabContainerView: View {
    var body: some View {
        TabView {
            ChartsView()
                .tabItem() {
                    Image(systemName: "house")
                    Text("Home")
                }
            PercentageCalculatorView()
                .tabItem() {
                    Image(systemName: "chart.bar")
                    Text("Allocation")
                }
            BenchMarkView()
                .tabItem() {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                    Text("Benchmark")
                }
            ChartsView()
                .tabItem() {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
