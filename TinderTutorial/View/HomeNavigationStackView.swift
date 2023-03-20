//
//  HomeNavigationStackView.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 28.02.2023.
//

import UIKit

// MARK: - HomeNavigationStackViewDelegate
protocol HomeNavigationStackViewDelegate: AnyObject {
    func showSettings()
    func showMessages()
}

final class HomeNavigationStackView: UIStackView {
    // MARK: - Properties
    weak var delegate: HomeNavigationStackViewDelegate?
    
    private let settingsButton = UIButton(type: .system)
    private let messageButton = UIButton(type: .system)
    private let tinderIcon = UIImageView(image: #imageLiteral(resourceName: "app_icon"))

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        heightAnchor.constraint(equalToConstant: 80).isActive = true
        tinderIcon.contentMode = .scaleAspectFit
        
        settingsButton.setImage(UIImage(named: "top_left_profile")?
            .withRenderingMode(.alwaysOriginal), for: .normal)
        messageButton.setImage(UIImage(named: "top_right_messages")?
            .withRenderingMode(.alwaysOriginal), for: .normal)
        
        [settingsButton,
         UIView(),
         tinderIcon,
         UIView(),
         messageButton].forEach { view in
            addArrangedSubview(view)
        }
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        
        settingsButton.addTarget(self,
                                 action: #selector(handleShowSettings),
                                 for: .touchUpInside)
        
        messageButton.addTarget(self,
                                action: #selector(handleShowMessages),
                                for: .touchUpInside)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func handleShowSettings() {
        delegate?.showSettings()
    }
    
    @objc func handleShowMessages() {
        delegate?.showMessages()
    }
}
