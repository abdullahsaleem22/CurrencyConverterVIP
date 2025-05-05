//
//  ConverterInteractor.swift
//  CurrencyConverter2
//
//  Created by Abdullah Saleem on 30/04/2025.
//

import Foundation

typealias ConverterInteractorInput = ConverterVCOutput

protocol ConverterInteractorOutput{
    func showConverted(result:String)
}

final class ConverterInteractor{
    var presenter: ConverterPresenterInput?
    var worker: CurrencyApiLogic?
    
}

extension ConverterInteractor:ConverterInteractorInput{
    func convert(from:String, to:String, num:String) async  {
        guard let response :ExchangeRatesResponse = await worker?.apiCall(from: from, to: to, num:num)else{
            return
        }
        
        guard let fromRate = response.rates[from] else{
            return
        }
        
        guard let toRate = response.rates[to] else{
            return
        }
        
        guard let number:Double = Double(num) else{
            return
        }
        
        var result = fromRate * number
        result = result * toRate
                   

        presenter?.showConverted(result: String(result))
    }
}
