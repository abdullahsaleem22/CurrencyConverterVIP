//
//  CurrencyApiWorker.swift
//  CurrencyConverter2
//
//  Created by Abdullah Saleem on 30/04/2025.
//

import Foundation

protocol CurrencyApiLogic{
    func apiCall(from:String, to:String, num:String) async -> ExchangeRatesResponse?
}

final class CurrencyApiWorker:CurrencyApiLogic{
    func apiCall(from:String, to:String, num:String) async -> ExchangeRatesResponse?{
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "openexchangerates.org"
        urlComponents.path = "/api/latest.json"
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
            let response = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)
           
            return response
            
        } catch {
            print("Error fetching currencies: \(error.localizedDescription)")
            return nil
        }
    }
}
