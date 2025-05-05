//
//  CurrencyListVC.swift
//  CurrencyConverter2
//
//  Created by Abdullah Saleem on 30/04/2025.
//

import UIKit

protocol CurrencyListVCInput{
    func showList(currencies:[Currency])
}
protocol CurrencyListVCOutput{
    func getList() async
}

class CurrencyListVC: UIViewController {

    @IBOutlet var table: UITableView!
    var currencies: [Currency] = []
    var label:String?
    var interactor : CurrencyListInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let interactor = CurrencyListInteractor()
        let presenter = CurrencyListPresenter()
        let worker = CurrencyListApiWorker()

        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = self
        
        self.interactor = interactor
        table.dataSource = self
        table.delegate = self
        Task{
            await self.interactor?.getList()
        }
    }
    
}

extension CurrencyListVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell")else{
            return UITableViewCell()
        }
        
        cell.textLabel?.text = currencies[indexPath.row].name + " - " + currencies[indexPath.row].isoCode
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name : String = label else{
            dismiss(animated: true)
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name(name), object: currencies[indexPath.row].isoCode)
        dismiss(animated: true)
    }
}


extension CurrencyListVC:CurrencyListVCInput{
    func showList(currencies:[Currency]) {
        self.currencies = currencies
        DispatchQueue.main.async { [weak self] in
            self?.table.reloadData()
        }
    }
}
