//
//  SendMoneyViewController.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import UIKit

protocol SendMoneyDisplayLogic: AnyObject {
    func displayResult(viewModel: SendMoney.SendAPICall.ViewModel)
}

class SendMoneyViewController: UIViewController, UITextFieldDelegate {
    
    var router: SendMoneyRoutingLogic?
    var interactor: SendMoneyBusinessLogic?
    
    private let amountField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter amount"
        field.borderStyle = .roundedRect
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        SendMoneyConfigurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        SendMoneyConfigurator.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Send Money"
        view.backgroundColor = .systemBackground
        
        view.addSubview(amountField)
        view.addSubview(submitButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .plain,
            target: self,
            action: #selector(signOutTapped)
        )
        
        setupConstraints()
        
        amountField.delegate = self
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        
    }
    
    private func setupConstraints() {
        amountField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        amountField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        amountField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        amountField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        amountField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 30).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func submitTapped() {
        let amount = amountField.text ?? ""
        if amount.isEmpty {
            showErrorAlert("Please enter an amount.")
            return
        }
        if let value = Double(amount) {
            interactor?.sendMoney(amount: value)
        }
        
    }
    
    @objc private func signOutTapped() {
        router?.signOut()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if string.isEmpty { return true }
        return string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    private func showErrorAlert(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    private func showResultSheet(amount: String, success: Bool) {
        DispatchQueue.main.async { [weak self] in
            let title = success ? "Success" : "Failed"
            let message = success ? "You sent ₱\(amount)!" : "Transaction failed. Please try again."
            
            let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            sheet.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                if success {
                    self?.navigationController?.popViewController(animated: true)
                }
            })
            
            self?.present(sheet, animated: true)
        }
    }
}

extension SendMoneyViewController: SendMoneyDisplayLogic {

    func displayResult(viewModel: SendMoney.SendAPICall.ViewModel) {
        showResultSheet(amount: viewModel.message, success: viewModel.success)
    }
}
