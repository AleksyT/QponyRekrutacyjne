//
//  Currency.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 25/01/2021.
//

import Foundation

struct Currency: Codable {
    let table: String
    let currency: String
    let code: String
    let rates: [Rate]
}
