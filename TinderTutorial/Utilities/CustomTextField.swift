//
//  CustomTextField.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 01.03.2023.
//

import UIKit

final class CustomTextField: UITextField {
    // MARK: - Lifecycle
    init(placeholder: String, isSecureTextEntry: Bool = false) {
        super.init(frame: .zero)
       
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        textColor = .white
        backgroundColor = UIColor(white: 1, alpha: 0.2)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        layer.cornerRadius = 5
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        self.isSecureTextEntry = isSecureTextEntry
        keyboardAppearance = .dark
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
