//
//  CurrencyListApiWorker.swift
//  CurrencyConverter2
//
//  Created by Abdullah Saleem on 01/05/2025.
//

import Foundation


protocol CurrencyListApiLogic{
    func apiCall() async -> [String: String]
}

final class CurrencyListApiWorker:CurrencyListApiLogic{
    func apiCall() async -> [String: String] {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "openexchangerates.org"
        urlComponents.path = "/api/currencies.json"
        urlComponents.queryItems = [
            URLQueryItem(name: "app_id", value: "d7b58765037e47e984a1ab1e7229be06")
        ]
        
        let url = urlComponents.url
        
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let currencyDictionary: [String: String] = try JSONDecoder().decode([String: String].self, from: data)
            
            
            return currencyDictionary
        } catch {
            print("Error fetching currencies: \(error.localizedDescription)")
            return [:]
        }
    }
}
