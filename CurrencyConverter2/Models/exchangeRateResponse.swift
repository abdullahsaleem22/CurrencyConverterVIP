//
//  exchangeRateResponse.swift
//  CurrencyConverter
//
//  Created by Abdullah Saleem on 29/04/2025.
//

import Foundation

struct ExchangeRatesResponse: Decodable {
    let base: String
    let rates: [String: Double]
}
