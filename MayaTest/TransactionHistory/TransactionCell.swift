//
//  TransactionCell.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let amountLabel = UILabel()
    let statusLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        amountLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        statusLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, amountLabel, statusLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(transaction: TransactionHistory.FetchHistory.TransactionViewModel) {
        nameLabel.text = transaction.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "PHP"
        amountLabel.text = transaction.amount
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        statusLabel.text = transaction.isSuccess ? "Success" : "Failed"
        statusLabel.textColor = transaction.isSuccess ? .systemGreen : .systemRed
    }
}

