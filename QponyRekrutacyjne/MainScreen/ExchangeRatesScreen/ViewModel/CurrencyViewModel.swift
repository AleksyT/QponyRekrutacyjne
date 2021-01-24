//
//  CurrencyViewModel.swift
//  QponyRekrutacyjne
//
//  Created by Aleksy Tylkowski on 23/01/2021.
//

import Foundation

class CurrencyViewModel {
    typealias CompletionHandler = (Result<[ExchangeRates], Error>) -> Void
    private static let url = "https://api.nbp.pl/api/exchangerates"
    private static let headerFields = ["format": "json"]
    
    func getExchangeRates(fromTable table: String, completion: @escaping CompletionHandler) {
        guard let url = URL(string: Self.url + "/tables" + "/\(table)") else { return }
        execute(url: url, completion: completion)
    }
    
    func getCurrencyExchangeRates(fromTable table: String, code: String, fromDate: String, toDate: String, completion: @escaping CompletionHandler) {
        guard let url = URL(string: Self.url + "/rates" + "/\(table)" + "/\(code)" + "/\(fromDate)" + "/\(toDate)") else { return }
        execute(url: url, completion: completion)
    }
    
    private func execute(url: URL, completion: @escaping CompletionHandler) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = Self.headerFields
        let dataTask = session.dataTask(with: URLRequest(url: url)) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let exchangeRates = try decoder.decode([ExchangeRates].self, from: data)
                    completion(.success(exchangeRates))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
