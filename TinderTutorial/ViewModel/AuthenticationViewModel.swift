//
//  AuthenticationViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 02.03.2023.
//

import Foundation

protocol AuthenticationViewModelProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationViewModelProtocol {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false
    }
}

struct RegistrationViewModel {
    var email: String?
    var fullName: String?
    var password: String?
    
    var formIsValid: Bool {
        email?.isEmpty == false &&
        fullName?.isEmpty == false &&
        password?.isEmpty == false
    }
}
