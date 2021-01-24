//
//  ExchangeRatesViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 24/01/2021.
//

import UIKit

class ExchangeRatesViewController: UIViewController {
    
    private var viewModel: CurrencyViewModel
    private var exchangeRates: ExchangeRates?
    private var spinner: SpinnerView = SpinnerView()
    private static let cellIdentifier = String(describing: ExchangeRatesViewCell.self)
    var currentTable: String?
    
    @IBOutlet private var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = CurrencyViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initialize()
    }
    
    func initialize() {
        currentTable = Table.A.rawValue
        getExchangeRates(fromTable: Table.A.rawValue)
    }
    
    private func showSpinner() {
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func hideSpinner() {
        spinner.removeFromSuperview()
    }
    
    private func initTableView() {
        tableView.backgroundColor = Colors().deepPurple
        tableView.register(UINib(nibName: Self.cellIdentifier, bundle: Bundle(for: Self.self)), forCellReuseIdentifier: Self.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func showError(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!", message: "Couldn't load exchange rates:  \(error)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.hideSpinner()
        }
    }
    
    func getExchangeRates(fromTable table: String) {
        self.currentTable = table
        self.showSpinner()
        viewModel.getExchangeRates(fromTable: table, completion: { result in
            switch result {
            case .failure(let error):
                self.showError(error)
            case .success(let exchangeRates):
                self.exchangeRates = exchangeRates.first
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.hideSpinner()
                }
            }
        })
    }
    
    func getCurrencyExchangeRates(fromTable table: String, code: String, fromDate: String, toDate: String) {
        self.currentTable = table
        self.showSpinner()
        viewModel.getCurrencyExchangeRates(fromTable: table, code: code, fromDate: fromDate, toDate: toDate, completion: { result in
            switch result {
            case .failure(let error):
                self.showError(error)
            case .success(let exchangeRates):
                self.exchangeRates = exchangeRates.first
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
