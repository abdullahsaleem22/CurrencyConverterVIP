//
//  CurrencyListInteractor.swift
//  CurrencyConverter2
//
//  Created by Abdullah Saleem on 01/05/2025.
//

import Foundation

typealias CurrencyListInteractorInput = CurrencyListVCOutput

protocol CurrencyListInteractorOutput{
    func showList(currencies:[Currency])
}

final class CurrencyListInteractor{
    var presenter : CurrencyListPresenterInput?
    var worker : CurrencyListApiWorker?
}

extension CurrencyListInteractor:CurrencyListInteractorInput{
    func getList() async {
        guard let currencyDictionary: [String: String] = await worker?.apiCall() else{
            return
        }
        
        var currencies : [Currency] = currencyDictionary.map { (key, value) in
            Currency(name: value, isoCode: key)
        }
        
        currencies.sort { $0.name < $1.name }
        presenter?.showList(currencies: currencies)
        
    }
}
