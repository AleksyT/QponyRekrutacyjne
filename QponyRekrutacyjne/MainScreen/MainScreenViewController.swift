//
//  MainScreenViewController.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 23/01/2021.
//

import UIKit

enum Table: String {
    case A
    case B
    case C
}

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    
    @IBOutlet private var containerView: UIView!
    
    private lazy var exchangeRatesTableViewController: ExchangeRatesViewController = {
        ExchangeRatesViewController()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachChild(exchangeRatesTableViewController, inside: containerView)
    }
    
    @IBAction private func onTableAction(_ sender: Any) {
        guard let button = sender as? UIButton,
              let table = button.titleLabel?.text else { return }
        switch table {
        case Table.A.rawValue:
            makeButtons(selected: aButton, unselected: [bButton, cButton])
        case Table.B.rawValue:
            makeButtons(selected: bButton, unselected: [aButton, cButton])
        case Table.C.rawValue:
            makeButtons(selected: cButton, unselected: [aButton, bButton])
        default:
            break
        }
        exchangeRatesTableViewController.getExchangeRates(fromTable: table)
    }
    
    @IBAction func onRefresh(_ sender: Any) {
        let heavyFont = UIFont.systemFont(ofSize: 26.0, weight: .heavy)
        var table: String
        if bButton.titleLabel?.font == heavyFont {
            table = Table.B.rawValue
        } else if cButton.titleLabel?.font == heavyFont {
            table = Table.C.rawValue
        } else {
            table = Table.A.rawValue
        }
        exchangeRatesTableViewController.getExchangeRates(fromTable: table)
    }
    
    
    private func makeButtons(selected selectedButton: UIButton, unselected unselectedButtons: [UIButton]) {
        selectedButton.titleLabel?.font = UIFont.systemFont(ofSize: 26.0, weight: .heavy)
        unselectedButtons.forEach {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 26.0, weight: .light)
        }
    }
}
