//
//  CurrencyListPresenter.swift
//  CurrencyConverter2
//
//  Created by Abdullah Saleem on 01/05/2025.
//

import Foundation

typealias CurrencyListPresenterInput = CurrencyListInteractorOutput

typealias CurrencyListPresenterOutput = CurrencyListVCInput

final class CurrencyListPresenter{
    weak var viewController: CurrencyListVC?
}

extension CurrencyListPresenter:CurrencyListPresenterInput{
    func showList(currencies:[Currency]) {
        viewController?.showList(currencies: currencies)
    }
}
