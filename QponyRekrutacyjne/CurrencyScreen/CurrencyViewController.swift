//
//  CurrencyViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 24/01/2021.
//

import UIKit

class CurrencyViewController: StandardTableViewController {
    private var currency: Currency?
    var table: String
    var code: String
    private var fromDate: String
    private var toDate: String

    init(table: String, code: String, fromDate: String, toDate: String) {
        self.table = table
        self.code = code
        self.fromDate = fromDate
        self.toDate = toDate
        super.init(nibName: String(describing: StandardTableViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        tableView.delegate = self
        tableView.dataSource = self
        currentTable = table
        getCurrencyExchangeRates(fromTable: table, code: code, fromDate: fromDate, toDate: toDate)
    }
    
    func getCurrencyExchangeRates(fromTable table: String, code: String, fromDate: String, toDate: String) {
        self.currentTable = table
        self.showSpinner()
        viewModel.getCurrencyExchangeRates(fromTable: table, code: code, fromDate: fromDate, toDate: toDate, completion: { result in
            switch result {
            case .failure(let error):
                self.showError(error)
            case .success(let currency):
                self.currency = currency as? Currency
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideSpinner()
                }
            }
        })
    }
}

extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currency?.rates.count ?? 0
    }
}

extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? ExchangeRatesViewCell else {
            fatalError("Dequeued a cell of unexpected type")
        }
        let configuration = ExchangeRatesViewCell.CellConfiguration(rate: currency?.rates[indexPath.row], date: nil)
        cell.configure(configuration: configuration)
        
        return cell
    }
}
