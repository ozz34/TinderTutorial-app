//
//  AuthenticationViewModel.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 02.03.2023.
//

import Foundation

// MARK: - AuthenticationViewModelProtocol
protocol AuthenticationViewModelProtocol {
    var formIsValid: Bool { get }
}

struct LoginViewModel: AuthenticationViewModelProtocol {
    // MARK: - Properties
    var email: String?
    var password: String?
    var formIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false
    }
}

struct RegistrationViewModel {
    // MARK: - Properties
    var email: String?
    var fullName: String?
    var password: String?

    var formIsValid: Bool {
        email?.isEmpty == false &&
            fullName?.isEmpty == false &&
            password?.isEmpty == false
    }
}
