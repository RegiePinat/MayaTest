//
//  LoginViewController.swift
//  MayaTest
//
//  Created by Guest  User on 9/25/25.
//

import UIKit

protocol LoginDisplayLogic: AnyObject {
    func displayErrorLoginResult(viewModel: Login.Authenticate.ViewModel)
    func displayWalletScreen()
}

class LoginViewController: UIViewController {

    var interactor: LoginBusinessLogic?
    var router: LoginRoutingLogic?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        LoginConfigurator.configure(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        LoginConfigurator.configure(self)
    }
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.borderStyle = .roundedRect
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.addTarget(nil, action: #selector(loginTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150).isActive = true
        usernameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc private func loginTapped() {
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        let request = Login.Authenticate.Request(username: username, password: password)
        interactor?.authenticate(request: request)
    }
    
}

extension LoginViewController: LoginDisplayLogic {
    
    func displayErrorLoginResult(viewModel: Login.Authenticate.ViewModel) {
        let alert = UIAlertController(title: "Login", message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func displayWalletScreen() {
        router?.routeToWallet()
    }
    
}
