//
//  LoginController.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Properties
    private let iconImageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "app_icon")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        
        return iv
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let passwordTextField = CustomTextField(placeholder: "Password",
                                                    isSecureTextEntry: true)
    
    private lazy var authButton = {
        let button = AuthButton(title: "Log In", type: .system)
        button.addTarget(self,
                         action: #selector(handleLogin),
                         for: .touchUpInside)
        
        return button
    }()
     
    private lazy var goToRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ",
                                                        attributes: [.foregroundColor: UIColor.white,
                                                                     .font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "Sigh Up",
                                                  attributes: [.foregroundColor: UIColor.white,
                                                               .font: UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self,
                         action: #selector(handleShowRegistration),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    @objc func handleLogin() {
       
    }
    
    @objc func handleShowRegistration() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        self.configureGradientLayer()
        
        view.addSubview(iconImageView)
        iconImageView.centerX(inView: view)
        iconImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImageView.setDimensions(height: 100, width: 100)
        
        let stack = UIStackView(arrangedSubviews: [emailTextField,
                                                  passwordTextField,
                                                  authButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: iconImageView.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 24,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        view.addSubview(goToRegistrationButton)
        goToRegistrationButton.anchor(left: view.leftAnchor,
                                      bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                      right: view.rightAnchor,
                                      paddingLeft: 32,
                                      paddingRight: 32)
    }
}
                                      
