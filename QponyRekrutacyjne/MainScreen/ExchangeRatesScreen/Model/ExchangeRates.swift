//
//  ExchangeRates.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 23/01/2021.
//

import Foundation

struct ExchangeRates: Codable {
    let table: String
    let no: String
    let tradingDate: String?
    let effectiveDate: String
    let rates: [Rate]
}
