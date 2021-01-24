//
//  SecondScreenViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 24/01/2021.
//

import UIKit

class SecondScreenViewController: UIViewController {
    
    let viewModel: CurrencyViewModel
    
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var containerView: UIView!
    
    private var currencyTableViewController: CurrencyViewController
    
    init(title: String, table: String, code: String) {
        viewModel = CurrencyViewModel()
        currencyTableViewController = CurrencyViewController(table: table, code: code)
        super.init(nibName: String(describing: Self.self), bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachChild(currencyTableViewController, inside: containerView)
    }
}
