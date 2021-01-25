//
//  Rate.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 23/01/2021.
//

import Foundation

struct Rate: Codable {
    let no: String?
    let currency: String
    let code: String
    let bid: Float?
    let ask: Float?
    let mid: Float?
}
