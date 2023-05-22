//
//  Portfolio.swift
//  StocksPortfolio
//
//  Created by RAMESH on 14/05/23.
//

class Portfolio {
    var stocks: [Scrip] = []
    var parser: Parser = Parser()
    
    func populateStocks() {
        stocks = parser.readCSVFromBundle()
    }
    
    func filterBySector(_ sector: String) -> [Scrip] {
        return stocks.filter() { $0.sector == sector }
    }

    func totalPortfolioInvestment() -> Double {
       let investment = stocks.reduce(0.0) { result, stock in
            let acquisitionCost = stock.averageCost * Double(stock.quantity)
            return result + acquisitionCost
        }
        return investment
    }
    
    func investmentsPerSector() -> [Sector]  {
        populateStocks()
        let sectors = Array(parser.sectors)
        if sectors.isEmpty { return [] }
        var sectorArray: [Sector] = []
        let totalInvestment = totalPortfolioInvestment()
        for sector in sectors {
            let investment = filterBySector(sector).reduce(0.0) { result, stock in
                let acquisitionCost = stock.averageCost * Double( stock.quantity)
                return result + acquisitionCost
            }
            var sectorDetails = Sector(category:.sector(SectorType(rawValue: sector)!) , initialValue: investment)
            sectorDetails.totalAllocation = totalInvestment
            print(sectorDetails.description)
            sectorArray.append(sectorDetails)
        }
        return sectorArray
    }
}
