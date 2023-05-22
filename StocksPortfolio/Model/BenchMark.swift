//
//  BenchMark.swift
//  StocksPortfolio
//
//  Created by RAMESH on 14/05/23.
//
import Foundation

class BenchMark {
    var parser: Parser = Parser()
    var benchmarkIndicies: [NIFTYIndex] = []
    
    lazy var dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd MMM yyyy"
            df.timeZone = TimeZone(abbreviation: "GMT")
            return df
    }()
    
    func populateIndicies() {
        benchmarkIndicies = parser.parseNIFTYIndex()
        //dump(benchmarkIndicies)
        let date = dateFormatter.date(from: "30 Dec 2022")
        print("XYZ Date:\(date)")
        indexReturns()
    }
//    func computeCAGR(index: [NIFTYIndex]) ->  {
//        
//    }
    func indexReturns()  {
        for benchmark in parser.benchmarkIndices {
            var filterArray = benchmarkIndicies.filter() { $0.name == benchmark }
            filterArray.sort {
                return $0.date > $1.date
            }
            dump(filterArray)
            if let openPrice = filterArray.first?.openPrice, let closePrice =  filterArray.last?.closePrice {
                closePrice - openPrice
            }
            
        }
    }
}
