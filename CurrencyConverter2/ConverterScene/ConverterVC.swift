//
//  ConverterVC.swift
//  CurrencyConverter2
//
//  Created by Abdullah Saleem on 30/04/2025.
//

import UIKit

protocol ConverterVCInput{
    func showConverted(result:String)
}

protocol ConverterVCOutput{
    func convert(from:String, to:String, num:String) async
}

class ConverterVC: UIViewController {

    @IBOutlet var ToLabel: UILabel!
    @IBOutlet var FromLabel: UILabel!
    
    @IBOutlet var FromNumber: UITextField!
    @IBOutlet var ToNumber: UITextField!
    
    var interactor : ConverterInteractorInput?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let interactor = ConverterInteractor()
        let presenter = ConverterPresenter()
        let worker = CurrencyApiWorker()
            
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = self
        
        self.interactor = interactor
        
        NotificationCenter.default.addObserver(self, selector: #selector(reciveFromLabel), name: Notification.Name("from"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reciveToLabel), name: Notification.Name("to"), object: nil)
        
        
        ToNumber.isUserInteractionEnabled = false
        ToNumber.layer.borderWidth = 1
        ToNumber.layer.borderColor = UIColor.systemOrange.cgColor
        ToNumber.layer.cornerRadius = 8
        ToNumber.layer.masksToBounds = true
        
        FromNumber.keyboardType = .decimalPad
        FromNumber.layer.borderWidth = 1
        FromNumber.layer.borderColor = UIColor.systemOrange.cgColor
        FromNumber.layer.cornerRadius = 8
        FromNumber.layer.masksToBounds = true
        FromNumber.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func ConvertBtnClicked(_ sender: Any)  {
        guard let from:String = FromLabel.text else{
            return
        }
        
        guard let to:String = ToLabel.text else{
            return
        }
        
        guard let num:String = FromNumber.text else{
            return
        }
        
        Task {
            await  self.interactor?.convert(from: from, to: to, num: num)
        }
    }
    
    @IBAction func FromBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toList", sender: "from")
    }
    
    @IBAction func ToBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toList", sender: "to")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! CurrencyListVC
        
        destVC.label = sender as? String
    }
    
    @objc func reciveFromLabel(_ notification : Notification){
        self.FromLabel.text = notification.object as! String?;
    }
    @objc func reciveToLabel(_ notification : Notification){
        self.ToLabel.text = notification.object as! String?;
    }
}

extension ConverterVC:ConverterVCInput{
    func showConverted(result:String) {
        DispatchQueue.main.async { [weak self] in
            self?.ToNumber.text = result
        }
    }
}

extension ConverterVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemOrange.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
    }
}
