//
//  StandardTableViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 24/01/2021.
//

import UIKit

class StandardTableViewController: UIViewController {
    
    var viewModel: ViewModel
    private var spinner: SpinnerView = SpinnerView()
    static let cellIdentifier = String(describing: ExchangeRatesViewCell.self)
    var currentTable: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        viewModel = ViewModel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTableView() {
        tableView.backgroundColor = Colors().deepPurple
        tableView.register(UINib(nibName: Self.cellIdentifier, bundle: Bundle(for: Self.self)), forCellReuseIdentifier: Self.cellIdentifier)
    }
    
    func showSpinner() {
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.widthAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 100).isActive = true
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func hideSpinner() {
        spinner.removeFromSuperview()
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!", message: "Couldn't load exchange rates:  \(error)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.hideSpinner()
        }
    }
}

