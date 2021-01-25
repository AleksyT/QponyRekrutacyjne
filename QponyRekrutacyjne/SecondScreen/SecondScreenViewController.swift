//
//  SecondScreenViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 24/01/2021.
//

import UIKit

class SecondScreenViewController: UIViewController {
    
    let viewModel: ViewModel

    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var containerView: UIView!
    
    private var currencyTableViewController: CurrencyViewController?
    
    init(title: String, table: String, code: String) {
        viewModel = ViewModel()
        super.init(nibName: String(describing: Self.self), bundle: nil)
                
        currencyTableViewController = CurrencyViewController(table: table, code: code, fromDate: "2020-01-01", toDate: "2020-01-25")
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachChild(currencyTableViewController!, inside: containerView)
    }
    
    @IBAction func onDateChange(_ sender: Any) {
        guard let table = currencyTableViewController?.table,
              let code = currencyTableViewController?.table else { return }
        currencyTableViewController?.getCurrencyExchangeRates(fromTable: table, code: code, fromDate: toDate(date: fromDatePicker.date), toDate: toDate(date: toDatePicker.date))
    }
    
    func toDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
