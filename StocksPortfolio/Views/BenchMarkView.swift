//
//  BenchMarkView.swift
//  StocksPortfolio
//
//  Created by RAMESH on 14/05/23.
//

import SwiftUI

struct BenchMarkView: View {
    var indices = BenchMark().populateIndicies()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BenchMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BenchMarkView()
    }
}
