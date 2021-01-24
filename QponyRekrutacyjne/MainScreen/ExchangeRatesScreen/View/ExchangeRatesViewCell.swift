//
//  ExchangeRatesViewCell.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 23/01/2021.
//

import UIKit

class ExchangeRatesViewCell: UITableViewCell {
    
    typealias CellConfiguration = (rate: Rate?, date: String?)
    
    @IBOutlet private var iconBackgroundView: UIView!
    @IBOutlet private var iconLabel: UILabel!
    @IBOutlet private var codeLabel: UILabel!
    @IBOutlet private var currencyLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var midLabel: UILabel!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(configuration: CellConfiguration) {
        makeBackgroundDeepPurple(iconBackgroundView)
        makeCornersTurquiseRounded(iconBackgroundView)
        if let code = configuration.rate?.code {
            codeLabel.text = code
            iconLabel.text = getSymbol(forCurrencyCode: code)
        }
        if let currency = configuration.rate?.currency.capitalizingFirstLetter() {
            currencyLabel.text = currency
        }
        dateLabel.text = configuration.date
        if let mid = configuration.rate?.mid {
            midLabel.text = String(describing: mid)
        }
    }
    
    func getTitle() -> String? {
        return currencyLabel.text
    }
    
    func getCode() -> String? {
        return codeLabel.text
    }
}

private func makeCornersTurquiseRounded(_  view: UIView) {
    view.layer.cornerRadius = view.frame.width / 2
    view.clipsToBounds = true

    view.layer.borderColor = Colors().turquise.cgColor
    view.layer.borderWidth = 2.0
}

private func makeBackgroundDeepPurple(_  view: UIView) {
    view.backgroundColor = Colors().deepPurple
}

private func getSymbol(forCurrencyCode code: String) -> String? {
    let locale = NSLocale(localeIdentifier: code)
    if locale.displayName(forKey: .currencySymbol, value: code) == code {
        let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
        return newlocale.displayName(forKey: .currencySymbol, value: code)
    }
    return locale.displayName(forKey: .currencySymbol, value: code)
}
