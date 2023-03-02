//
//  RegistrationController.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

class RegistrationController: UIViewController {
    // MARK: - Properties
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        
        button.addTarget(self,
                         action: #selector(handleSelectPhoto),
                         for: .touchUpInside)
        
        return button
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullNameTextField = CustomTextField(placeholder: "Full Name")
    private let passwordTextField = CustomTextField(placeholder: "Password",
                                                    isSecureTextEntry: true)
    
    private lazy var authButton = {
        let button = AuthButton(title: "Sigh Up", type: .system)
        button.addTarget(self,
                         action: #selector(handleRegisterUser),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ",
                                                        attributes: [.foregroundColor: UIColor.white,
                                                                     .font: UIFont.systemFont(ofSize: 16)])
        attributedTitle.append(NSAttributedString(string: "Log In",
                                                  attributes: [.foregroundColor: UIColor.white,
                                                               .font: UIFont.boldSystemFont(ofSize: 16)]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self,
                         action: #selector(handleShowLogin),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Actions
    @objc func handleSelectPhoto() {
        
    }
    
    @objc func handleRegisterUser() {
        
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 paddingTop: 8,
                                 width: 275,
                                 height: 275)
       
        let stack = UIStackView(arrangedSubviews: [emailTextField,
                                                   fullNameTextField,
                                                   passwordTextField,
                                                   authButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top: selectPhotoButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 16,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        view.addSubview(goToLoginButton)
        goToLoginButton.anchor(left: view.leftAnchor,
                               bottom: view.safeAreaLayoutGuide.bottomAnchor,
                               right: view.rightAnchor,
                               paddingLeft: 32,
                               paddingRight: 32)
    }
}
