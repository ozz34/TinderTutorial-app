//
//  SettingsHeader.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 05.03.2023.
//

import UIKit

class SettingsHeader: UIView {
    // MARK: - Properties
    var buttons = [UIButton]()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGroupedBackground
        let button1 = createButton()
        let button2 = createButton()
        let button3 = createButton()
        
        addSubview(button1)
        button1.anchor(top: topAnchor,
                       left: leftAnchor,
                       bottom: bottomAnchor,
                       paddingTop: 16,
                       paddingLeft: 16,
                       paddingBottom: 16)
        button1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [button2,
                                                  button3])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        
        addSubview(stack)
        stack.anchor(top: topAnchor,
                     left: button1.rightAnchor,
                     bottom: bottomAnchor,
                     right: rightAnchor,
                     paddingTop: 16,
                     paddingLeft: 16,
                     paddingBottom: 16,
                     paddingRight: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func handleSelectPhoto(){
        print("Show photo")
    }
    
    // MARK: - Helpers
    func createButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.imageView?.contentMode = .scaleAspectFill
        
        return button
    }
}
