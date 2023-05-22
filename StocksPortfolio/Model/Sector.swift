//
//  Sector.swift
//  StocksPortfolio
//
//  Created by RAMESH on 14/05/23.
//

import Foundation

enum SectorType: String {
    case it = "IT"
    case financialServices = "Financial Services"
    case fmcg = "FMCG"
    case pharma = "Pharma"
}
enum SectorCategory {
    case sector(SectorType)

    var title: String {
        switch self {
        case .sector: return "Sector"
        }
    }
    
    var category: String {
        switch self {
        case .sector(let sectorType):
            switch sectorType {
            case .it: return "IT"
            case .financialServices: return"Financial Services"
            case .fmcg: return"FMCG"
            case .pharma: return"Pharma"
            }
        }
    }
}

struct Sector: Identifiable {
    let id = UUID()
    let category: SectorCategory
    let initialValue: Double
    let finalValue: Double = 0
    var allocation: Double = 0
    
    var totalAllocation: Double = 0 {
        didSet {
            allocation = (initialValue/totalAllocation) * 100
        }
    }
    var plPercentage: Double {
        get {
           return  ((finalValue - initialValue)/initialValue) * 100
        }
    }
    
    var description : String {
        var descritpion = " " + "\n"
        descritpion += initialValue.display() + "\n"
        descritpion += finalValue.display() + "\n"
        descritpion += allocation.display() + "\n"
        descritpion += totalAllocation.display() + "\n"
        return descritpion
    }
}
