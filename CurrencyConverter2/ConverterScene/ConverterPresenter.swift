//
//  ConverterPresenter.swift
//  CurrencyConverter2
//
//  Created by Abdullah Saleem on 30/04/2025.
//

import Foundation

typealias ConverterPresenterInput = ConverterInteractorOutput

typealias ConverterPresenterOutput = ConverterVCInput

final class ConverterPresenter{
    weak var viewController: ConverterVC?
}

extension ConverterPresenter: ConverterPresenterInput{
    func showConverted(result:String) {
        viewController?.showConverted(result: result)
    }
    
}
