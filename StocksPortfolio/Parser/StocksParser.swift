//
//  Parser.swift
//  FileBrowser
//
//  Created by RAMESH on 12/05/23.
//

import Foundation
import SwiftCSV

struct Scrip {
    let name: String
    let quantity: Int
    let averageCost: Double
    let currentValue: Double
    let pnl: Double
    let sector: String
}
struct NIFTYIndex {
    let name: String
    let date: Date
    let dateString: String
    let low: Double
    let high: Double
    let openPrice: Double
    let closePrice: Double
}

class Parser {
    var sectors = Set<String>()
    var benchmarkIndices = Set<String>()
    
    lazy var dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "dd MMM yyyy"
            df.timeZone = TimeZone(abbreviation: "GMT")
            return df
    }()
    
    fileprivate func displayScrips(_ scrips: [Scrip]) {
        for scrip in scrips {
            print(scrip)
        }
    }
    
    fileprivate func displayIndices(_ indicies: [NIFTYIndex]) {
        for index in indicies {
            print(index)
        }
    }
    
    func readCSVFromBundle() -> [Scrip] {
        guard let path = Bundle.main.path(forResource: "stocks1", ofType: "csv") else {
            print("CSV file not found in the bundle.")
            return []
        }
        var scrips: [Scrip] = []
        do {
            let csv = try CSV<Named>(url: URL(fileURLWithPath: path))
            let rows = csv.rows
            for row in rows {
        
                guard let quantity = Int(row[csv.header[1]] ?? ""),
                      let averageCost = Double(row[csv.header[2]] ?? ""),
                      let currentValue = Double(row[csv.header[3]] ?? ""),
                      let pnl = Double(row[csv.header[4]] ?? "") else {
                      return scrips
                }
                let csvRow = Scrip(
                    name: row[csv.header[0]] ?? "",
                    quantity: quantity,
                    averageCost: averageCost,
                    currentValue: currentValue,
                    pnl: pnl,
                    sector: row[csv.header[5]] ?? ""
                )
                scrips.append(csvRow)
                sectors.insert(row[csv.header[5]] ?? "")
                displayScrips(scrips)
            }
        } catch {
            print("Error reading the CSV file:", error.localizedDescription)
            return scrips
        }
        return scrips
    }
    
    func readCSVFile(name: String) -> CSV<Named>? {
        guard let path = Bundle.main.path(forResource: name, ofType: "csv") else {
            print("CSV file not found in the bundle.")
            return nil
        }
        do {
            let csv = try CSV<Named>(url: URL(fileURLWithPath: path))
            return csv
        }
        catch {
            print("Error reading the CSV file:", error.localizedDescription)
            return nil
        }
    }
    func parseNIFTYIndex() -> [NIFTYIndex] {
        
        var niftyIndex: [NIFTYIndex] = []
        
        guard let csv =  readCSVFile(name: "NIFTY_Indicies") else {
            return niftyIndex
        }
       
        let rows = csv.rows
        for row in rows {
            //Date,Open,High,Low,Close,Index
            guard let openPrice = Double(row[csv.header[2]] ?? ""),
                  let high = Double(row[csv.header[3]] ?? ""),
                  let low = Double(row[csv.header[4]] ?? ""),
                  let closePrice = Double(row[csv.header[4]] ?? "")
                  else {
                return niftyIndex
            }
            print("Date:\(row[csv.header[0]])")
            //let date1 = Date(timeIntervalSince1970: row[csv.header[1]])
            //print("dare1:\(date1)")
            let date = dateFormatter.date(from: row[csv.header[0]] ?? "") ?? Date()
            let csvRow = NIFTYIndex(name: row[csv.header[5]] ?? "", date: date,
                                    dateString: row[csv.header[0]] ?? "",
                                    low: low, high: high,
                                    openPrice: openPrice,
                                    closePrice: closePrice)
            niftyIndex.append(csvRow)
            benchmarkIndices.insert(row[csv.header[5]] ?? "")
            displayIndices(niftyIndex)
        }
        return niftyIndex
    }
}





