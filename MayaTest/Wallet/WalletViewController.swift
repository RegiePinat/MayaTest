//
//  WalletViewController.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import UIKit

protocol WalletDisplayLogic: AnyObject {
    func displayWalletBalance(viewModel: Wallet.FetchWallet.ViewModel)
    func showWalletBalance(viewModel: Wallet.DisplayWallet.ViewModel)
    func hideWalletBalance(viewModel: Wallet.DisplayWallet.ViewModel)
}

struct WalletConstants {
    static let showText = "Show"
    static let hideText = "Hide"
}

class WalletViewController: UIViewController {
    
    var router: WalletRoutingLogic?
    var interactor: WalletBusinessLogic?
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "₱0.00"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(WalletConstants.hideText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let sendMoneyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Money", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let transactionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View Transactions", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        WalletConfigurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        WalletConfigurator.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Wallet"
        view.backgroundColor = .systemBackground
        
        view.addSubview(balanceLabel)
        view.addSubview(toggleButton)
        view.addSubview(sendMoneyButton)
        view.addSubview(transactionsButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .plain,
            target: self,
            action: #selector(signOutTapped)
        )
        
        setupConstraints()
        
        toggleButton.addTarget(self, action: #selector(toggleBalance), for: .touchUpInside)
        sendMoneyButton.addTarget(self, action: #selector(sendMoneyTapped), for: .touchUpInside)
        transactionsButton.addTarget(self, action: #selector(viewTransactionsTapped), for: .touchUpInside)
        
        interactor?.requestWalletValue()
    }
    
    private func setupConstraints() {
            balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
            
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            toggleButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 10).isActive = true
            
            sendMoneyButton.topAnchor.constraint(equalTo: toggleButton.bottomAnchor, constant: 50).isActive = true
            sendMoneyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            sendMoneyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            sendMoneyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            transactionsButton.topAnchor.constraint(equalTo: sendMoneyButton.bottomAnchor, constant: 20).isActive = true
            transactionsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            transactionsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            transactionsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    @objc private func toggleBalance() {
        if self.toggleButton.titleLabel?.text == WalletConstants.showText {
            interactor?.showWalletValue()
        } else {
            interactor?.hideWalletValue()
        }
    }
    
    @objc private func sendMoneyTapped() {
        router?.routeToSendMoney()
    }
    
    @objc private func viewTransactionsTapped() {
        router?.routeToTransactionHistory()
    }
    
    @objc private func signOutTapped() {
        router?.signOut()
    }
    
    func hideBalance(text: String) {
        self.toggleButton.setTitle(WalletConstants.showText, for: .normal)
        balanceLabel.text = text
    }
    
    func showBalance(text: String) {
        self.toggleButton.setTitle(WalletConstants.hideText, for: .normal)
        balanceLabel.text = text
    }
    
}


extension WalletViewController: WalletDisplayLogic {
    
   
    func displayWalletBalance(viewModel: Wallet.FetchWallet.ViewModel) {
        balanceLabel.text = viewModel.balanceText
    }
    
    func showWalletBalance(viewModel: Wallet.DisplayWallet.ViewModel) {
        showBalance(text: viewModel.balanceText)
    }
    
    func hideWalletBalance(viewModel: Wallet.DisplayWallet.ViewModel) {
        hideBalance(text: viewModel.balanceText)
    }
}
