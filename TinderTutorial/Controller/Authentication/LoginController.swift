//
//  LoginController.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

protocol AuthenticationDelegate: AnyObject {
    func authenticationComplete()
}

class LoginController: UIViewController {
    // MARK: - Properties
    
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    
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
        configureTextFieldObservers()
    }
    
    // MARK: - Actions
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error {
                print("Debug: Error logging user in \(error.localizedDescription)")
            }
            self.delegate?.authenticationComplete()
        }
    }
    
    @objc func handleShowRegistration() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
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
    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self,
                                 action: #selector(textDidChange),
                                 for: .editingChanged)
        passwordTextField.addTarget(self,
                                 action: #selector(textDidChange),
                                 for: .editingChanged)
    }
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            authButton.isEnabled = true
            authButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            authButton.isEnabled = false
            authButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
                                      
