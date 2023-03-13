//
//  MatchView.swift
//  TinderTutorial
//
//  Created by Иван Худяков on 13.03.2023.
//

import UIKit

class MatchView: UIView {
    // MARK: - Properties
    private let currentUser: User
    private let matchedUser: User
    
    private let matchImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "itsamatch"))
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "You and Joker have liked each other!"
        
        return label
    }()
    
    private let currentUserImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "jane1"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        
        return iv
    }()
    
    private let matchedUserImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "jane1"))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.white.cgColor
        
        return iv
    }()
    
    private lazy var sendMessageButton: UIButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("SEND MESSAGE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(didTapSendMessage),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var keepSwipingButton: UIButton = {
        let button = SendMessageButton(type: .system)
        button.setTitle("Keep swiping", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self,
                         action: #selector(didTapKeepSwiping),
                         for: .touchUpInside)
        
        return button
    }()
    
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    lazy var views = [
    matchImageView,
    descriptionLabel,
    currentUserImageView,
    matchedUserImageView,
    sendMessageButton,
    keepSwipingButton]
    
    // MARK: - Lifecycle
    init(currentUser: User, matchedUser: User) {
        self.currentUser = currentUser
        self.matchedUser = matchedUser
        super.init(frame: .zero)
        
        configureBlurView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Actions
    @objc func didTapSendMessage() {
        
    }
    
    @objc func didTapKeepSwiping() {
        
    }
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

    // MARK: - Helpers
    func configureUI() {
        views.forEach { view in
            addSubview(view)
            view.alpha = 1
        }
        
        currentUserImageView.anchor(left: centerXAnchor, paddingLeft: 16)
        currentUserImageView.setDimensions(height: 140, width: 140)
        currentUserImageView.layer.cornerRadius = 140 / 2
        currentUserImageView.centerY(inView: self)
        
        matchedUserImageView.anchor(right: centerXAnchor, paddingRight: 16)
        matchedUserImageView.setDimensions(height: 140, width: 140)
        matchedUserImageView.layer.cornerRadius = 140 / 2
        matchedUserImageView.centerY(inView: self)
        
        sendMessageButton.anchor(top: currentUserImageView.bottomAnchor,
                                 left: leftAnchor,
                                 right: rightAnchor,
                                 paddingTop: 32,
                                 paddingLeft: 48,
                                 paddingRight: 48)
        sendMessageButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        keepSwipingButton.anchor(top: sendMessageButton.bottomAnchor,
                                 left: leftAnchor,
                                 right: rightAnchor,
                                 paddingTop: 32,
                                 paddingLeft: 48,
                                 paddingRight: 48)
        keepSwipingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        descriptionLabel.anchor(left: leftAnchor,
                                bottom: currentUserImageView.topAnchor,
                                right: rightAnchor,
                                paddingLeft: 16,
                                paddingBottom: 32,
                                paddingRight: 16)
        matchImageView.anchor(bottom: descriptionLabel.topAnchor, paddingBottom: 16)
        matchImageView.centerX(inView: self)
        matchImageView.setDimensions(height: 80, width: 300)
    }
    
    func configureBlurView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        visualEffectView.addGestureRecognizer(tap)
        
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: { self.visualEffectView.alpha = 1 },
                       completion: nil)
    }
}
