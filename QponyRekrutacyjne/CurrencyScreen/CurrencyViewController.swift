//
//  CurrencyViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 24/01/2021.
//

import UIKit

class CurrencyViewController: ExchangeRatesViewController {
    
    private var table: String
    private var code: String

    init(table: String, code: String) {
        self.table = table
        self.code = code
        super.init(nibName: String(describing: ExchangeRatesViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initialize() {
        currentTable = table
        getCurrencyExchangeRates(fromTable: table, code: code, fromDate: "2021-01-15", toDate: "2021-01-23")
    }
}
