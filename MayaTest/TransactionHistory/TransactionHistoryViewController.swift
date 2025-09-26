//
//  TransactionHistoryViewController.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import UIKit

protocol TransactionHistoryDisplayLogic: AnyObject {
    func displayFetchedTransactionHistory(viewModel: TransactionHistory.FetchHistory.ViewModel)
    
    func displayErrorFetchHistoryResult(viewModel: TransactionHistory.FetchHistory.ViewModel)
}

class TransactionHistoryViewController: UIViewController, UITableViewDataSource {
    
    var router: TransactionHistoryRoutingLogic?
    var interactor: TransactionHistoryBusinessLogic?
    
    private var transactions: [TransactionHistory.FetchHistory.TransactionViewModel] = []
    private let tableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        TransactionHistoryConfigurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        TransactionHistoryConfigurator.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Transaction History"
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Sign Out",
            style: .plain,
            target: self,
            action: #selector(signOutTapped)
        )
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        interactor?.fetchTransactionHistory()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }
        cell.configure(transaction: transactions[indexPath.row])
        return cell
    }
    
    @objc private func signOutTapped() {
        router?.signOut()
    }
    
    
}

extension TransactionHistoryViewController: TransactionHistoryDisplayLogic {
    func displayFetchedTransactionHistory(viewModel: TransactionHistory.FetchHistory.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.transactions = viewModel.transactions
            self?.tableView.reloadData()
        }
    }
    
    func displayErrorFetchHistoryResult(viewModel: TransactionHistory.FetchHistory.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Fetch History Error", message: viewModel.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
            self?.transactions = viewModel.transactions
            self?.tableView.reloadData()
        }
    }
}
