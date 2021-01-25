//
//  ExchangeRatesViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 24/01/2021.
//

import UIKit

class ExchangeRatesViewController: StandardTableViewController {
    private var exchangeRates: ExchangeRates?    
    
    init() {
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
        currentTable = Table.A.rawValue
        getExchangeRates(fromTable: Table.A.rawValue)
    }
    
    func getExchangeRates(fromTable table: String) {
        self.currentTable = table
        self.showSpinner()
        viewModel.getExchangeRates(fromTable: table, completion: { result in
            switch result {
            case .failure(let error):
                self.showError(error)
            case .success(let exchangeRates):
                self.exchangeRates = (exchangeRates as? [ExchangeRates])?.first
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideSpinner()
                }
            }
        })
    }
}

extension ExchangeRatesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exchangeRates?.rates.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let table = currentTable,
              let cell = tableView.cellForRow(at: indexPath) as? ExchangeRatesViewCell,
              let code = cell.getCode(),
              let title = cell.getTitle() else { return }
        

        let secondScreen = SecondScreenViewController(title: title, table: table, code: code)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.pushViewController(secondScreen, animated: true)
    }
}

extension ExchangeRatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier, for: indexPath) as? ExchangeRatesViewCell else {
            fatalError("Dequeued a cell of unexpected type")
        }
        let configuration = ExchangeRatesViewCell.CellConfiguration(rate: exchangeRates?.rates[indexPath.row], date: exchangeRates?.effectiveDate)
        cell.configure(configuration: configuration)
        
        return cell
    }
}
